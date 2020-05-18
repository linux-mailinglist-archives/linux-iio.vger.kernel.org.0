Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071EC1D7583
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgERKsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 06:48:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERKsU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 06:48:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 849C52A04C1
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <e6030957-97dc-5b04-7855-bc14a78164c8@collabora.com>
Date:   Mon, 18 May 2020 12:48:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans,

W dniu 15.05.2020 o 20:19, Hans de Goede pisze:
> Hi Andrezj,
> 
> On 5/15/20 6:49 PM, Andrzej Pietrasiewicz wrote:
>> Userspace might want to implement a policy to temporarily disregard input
>> from certain devices, including not treating them as wakeup sources.
>>
>> An example use case is a laptop, whose keyboard can be folded under the
>> screen to create tablet-like experience. The user then must hold the laptop
>> in such a way that it is difficult to avoid pressing the keyboard keys. It
>> is therefore desirable to temporarily disregard input from the keyboard,
>> until it is folded back. This obviously is a policy which should be kept
>> out of the kernel, but the kernel must provide suitable means to implement
>> such a policy.
> 
> Actually libinput already binds together (inside libinput) SW_TABLET_MODE
> generating evdev nodes and e.g. internal keyboards on devices with 360°
> hinges for this reason. libinput simply closes the /dev/input/event#
> node when folded and re-opens it when the keyboard should become active
> again. Thus not only suppresses events but allows e.g. touchpads to
> enter runtime suspend mode which saves power. Typically closing the
> /dev/input/event# node will also disable the device as wakeup source.
> 
> So I wonder what this series actually adds for functionality for
> userspace which can not already be achieved this way?
> 
> I also noticed that you keep the device open (do not call the
> input_device's close callback) when inhibited and just throw away

I'm not sure if I understand you correctly, it is called:

+static inline void input_stop(struct input_dev *dev)
+{
+	if (dev->poller)
+		input_dev_poller_stop(dev->poller);
+	if (dev->close)
+		dev->close(dev);
                 ^^^^^^^^^^^^^^^^
+static int input_inhibit(struct input_dev *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->mutex);
+
+	if (dev->inhibited)
+		goto out;
+
+	if (dev->users) {
+		if (dev->inhibit) {
+			ret = dev->inhibit(dev);
+			if (ret)
+				goto out;
+		}
+		input_stop(dev);
                 ^^^^^^^^^^^^^^^^

It will not be called when dev->users is zero, but if it is zero,
then nobody has opened the device yet so there is nothing to close.

Andrzej
