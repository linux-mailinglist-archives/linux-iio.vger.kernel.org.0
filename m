Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CCF1DEBFC
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgEVPgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgEVPgC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:36:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B397C061A0E;
        Fri, 22 May 2020 08:36:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 7F0622A38F6
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <20200517225510.GA205823@koala> <20200518024034.GL89269@dtor-ws>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <513f25c0-7125-c564-0090-052d626fe508@collabora.com>
Date:   Fri, 22 May 2020 17:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518024034.GL89269@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans, hi Dmitry,

W dniu 18.05.2020 o 04:40, Dmitry Torokhov pisze:
> Hi Hans, Peter,
> 
> On Mon, May 18, 2020 at 08:55:10AM +1000, Peter Hutterer wrote:
>> On Fri, May 15, 2020 at 08:19:10PM +0200, Hans de Goede wrote:
>>> Hi Andrezj,
>>>

<snip>

>>
>>> I also noticed that you keep the device open (do not call the
>>> input_device's close callback) when inhibited and just throw away
>>> any events generated. This seems inefficient and may lead to
>>> the internal state getting out of sync. What if a key is pressed
>>> while inhibited and then the device is uninhibited while the key
>>> is still pressed?  Now the press event is lost and userspace
>>> querying the current state will see the pressed key as being
>>> released.
> 
> This is a good point. We should look into signalling that some events
> have been dropped (via EV_SYN/SYN_DROPPED) so that clients are aware of
> it.
> 

It seems to me that the situation Hans envisions is not possible,
or will not be possible with a simple change. Let me explain.

For a start, let's recall that the input core prevents consecutive
events of the same kind (type _and_ code _and_ value) from being
delivered to handlers. The decision is made in input_get_disposition().
For EV_KEY it is:

		if (is_event_supported(code, dev->keybit, KEY_MAX)) {

			/* auto-repeat bypasses state updates */
			if (value == 2) {
				disposition = INPUT_PASS_TO_HANDLERS;
				break;
			}

			if (!!test_bit(code, dev->key) != !!value) {

				__change_bit(code, dev->key);
				disposition = INPUT_PASS_TO_HANDLERS;
			}
		}

Let's now focus on value != 2 (events other than auto-repeat).
The disposition changes from the default INPUT_IGNORE_EVENT to
INPUT_PASS_TO_HANDLERS only when the event in question changes
the current state: either by releasing a pressed key, or by
pressing a released key. Subsequent releases of a released key
or subsequent presses of a pressed key will be ignored.

What Hans points out is the possibility of uninhibiting a device
while its key is pressed and then releasing the key. First of all,
during inhibiting input_dev_release_keys() is called, so input_dev's
internal state will be cleared of all pressed keys. Then the device
- after being uninhibited - all of a sudden produces a key release
event. It will be ignored as per the "subsequent releases of a
released key" case, so the handlers will not be passed an unmatched
key release event. Assuming that passing an unmatched key release
event was Hans's concern, in this case it seems impossible.

Now, the value of 2 (auto-repeat) needs some attention. There are two
cases to consider: the device uses input core's software repeat or it
uses its own (hardware) repeat.

Let's consider the first case. The timer which generates auto-repeat
is only started on a key press event and only stopped on a key release
event. As such, if any auto-repeat was in progress when inhibiting
happened, it must have been stopped as per input_dev_release_keys().
Then the key is pressed and held after the device has been inhibited,
and the device is being uninhibited. Since it uses software auto-repeat,
no events will be reported by the device until the key is released,
and, as explained above, the release event will be ignored.

Let's consider the second case. The key is pressed and held after the
device has been inhibited and the device is being uninhibited. The worst
thing that can happen is unmatched key repeat events will start coming
from the device. We must prevent them from reaching the handlers and
ignore them instead. So I suggest something on the lines of:

if (is_event_supported(code, dev->keybit, KEY_MAX)) {

			/* auto-repeat bypasses state updates */
-			if (value == 2) {
+			if (value == 2 && test_bit(code, dev->key)) {
				disposition = INPUT_PASS_TO_HANDLERS;
				break;
			}

The intended meaning is "ignore key repeat events if the key is not
pressed".

With this small change I believe it is not possible to have neither
unmatched release nor unmatched repeat being delivered to handlers.

Regards,

Andrzej
