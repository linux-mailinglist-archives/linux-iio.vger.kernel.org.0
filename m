Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF561F1564
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgFHJ2L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 05:28:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgFHJ2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 05:28:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id CEE412A10C1
Subject: Re: [PATCH v3 0/7] Support inhibiting input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
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
        kernel@collabora.com
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com> <20200607202414.GB13138@amd>
 <20200608053737.GS89269@dtor-ws>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <b1b282ed-ddea-fdd8-bf1a-3e918653f1e3@collabora.com>
Date:   Mon, 8 Jun 2020 11:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608053737.GS89269@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Pavel,

W dniu 08.06.2020 o 07:37, Dmitry Torokhov pisze:
> On Sun, Jun 07, 2020 at 10:24:14PM +0200, Pavel Machek wrote:
>> On Fri 2020-06-05 19:33:28, Andrzej Pietrasiewicz wrote:
>>> Userspace might want to implement a policy to temporarily disregard input
>>> from certain devices.
>>
>> Wow, you certainly cc a lot of lists.
>>
>>> An example use case is a convertible laptop, whose keyboard can be folded
>>> under the screen to create tablet-like experience. The user then must hold
>>> the laptop in such a way that it is difficult to avoid pressing the keyboard
>>> keys. It is therefore desirable to temporarily disregard input from the
>>> keyboard, until it is folded back. This obviously is a policy which should
>>> be kept out of the kernel, but the kernel must provide suitable means to
>>> implement such a policy.
>>>
>>> Due to interactions with suspend/resume, a helper has been added for drivers
>>> to decide if the device is being used or not (PATCH 1/7) and it has been
>>> applied to relevant drivers (PATCH 2,4,5,6/7).
>>
>> But is that a right way to implement it?
>>
>> We want this for cellphones, too -- touchscreen should be disabled
>> while the device is locked in the pocket -- but we really want the
>> touchscreen hardware to be powered down in that case (because it keeps
>> SoC busy and eats a _lot_ of electricity).
>>
>> But simplistic "receive an event and then drop it if device is
>> inhibited" does not allow that...
> 
> I do not think you read the entirety of this patch series...
> 

Yeah, kindly read the whole thread. Long story short: Inhibiting _is_ about
ignoring events from inhibited devices. Obviously we can do better than
just that. Indeed, the open() and close() callbacks (which are called at
uninhibiting/inhibiting) mean "start providing events" and "stop providing
events", respectively. How that translates into driver operation is highly
driver-specific and cannot be handled at the input subsystem level, but it
is the place where power savings can be realized: whenever the driver knows
that nobody wants events from it it can do whatever it considers appropriate,
including transitioning the device into low power mode, for example using
PM runtime.

Regards,

Andrzej
