Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4092284C28
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFNEe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 09:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNEd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 09:04:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A849C061755;
        Tue,  6 Oct 2020 06:04:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 7ECB0299E5B
Subject: Re: [PATCH v4 7/7] Input: Add "inhibited" property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
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
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Patrik Fimml <patrikf@chromium.org>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-8-andrzej.p@collabora.com>
 <20201005181014.GL1009802@dtor-ws>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <ac4eeab7-8333-b96b-707b-eb2d6d0d8139@collabora.com>
Date:   Tue, 6 Oct 2020 15:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005181014.GL1009802@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

W dniu 05.10.2020 o 20:10, Dmitry Torokhov pisze:
> Hi Andrzej,
> 
> On Mon, Jun 08, 2020 at 01:22:11PM +0200, Andrzej Pietrasiewicz wrote:
>> @@ -284,8 +284,11 @@ static int input_get_disposition(struct input_dev *dev,
>>   	case EV_KEY:
>>   		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
>>   
>> -			/* auto-repeat bypasses state updates */
>> -			if (value == 2) {
>> +			/*
>> +			 * auto-repeat bypasses state updates but repeat
>> +			 * events are ignored if the key is not pressed
>> +			 */
>> +			if (value == 2 && test_bit(code, dev->key)) {
>>   				disposition = INPUT_PASS_TO_HANDLERS;
>>   				break;
>>   			}
> 
> Is this chunk really part of inhibit support? I'd think we cancel
> autorepeat timer when we are releasing a key, no?
> 

When I look at it now it seems to me the chunk might be redundant.
But let me explain what I had in mind when adding it.

It is a matter of what we do with input events generated while a
device is inhibited. If ->open()/->close() are not provided by the
driver then inhibiting amounts to merely ignoring input events from
a device while it remains active. What else can you do if the driver
does not provide a method to prepare the device for generating events/
to stop generating events?

In this special case a user might trigger a repeated event while the
device is inhibited, then the user keeps holding the key down and the
device is uninhibited. Do we pass anything to handlers then?

In my opinion we should not. Such an event is "illegal" in a sense that it
was generated at a time when nobody wanted any events from the device.
Hence the test to let only those auto-repeat events through for which
a key is actually pressed.

However, what I see now is that if a device is inhibited, no key
will ever reach neither the "1" nor "2" state because of the "if"
in the very beginning of input_handle_event().

Regards,

Andrzej
