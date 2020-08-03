Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0872C23A8AD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHCOlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 10:41:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B21C06174A;
        Mon,  3 Aug 2020 07:41:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 6EA3629A06E
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
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
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <1821a5b7-cbf3-a739-2203-a93b06f0c6f2@redhat.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <8fc3a97d-94b7-e073-3981-2f146f5f209e@collabora.com>
Date:   Mon, 3 Aug 2020 16:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1821a5b7-cbf3-a739-2203-a93b06f0c6f2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

W dniu 12.06.2020 o 10:17, Hans de Goede pisze:
> Hi,
> 
> On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
>> This is a quick respin of v3, with just two small changes, please see
>> the changelog below.
>>
>> Userspace might want to implement a policy to temporarily disregard input
>> from certain devices.
>>

<snip>

>> v3..v4:
>> - updated the comment in input_open_device() (Hans)
>> - used more straightforward locking pattern in adc/exynos (Michał)
>>
>> v2..v3:
>> - ignored autorepeat events in input_get_disposition() if a key is not
>> pressed (Hans)
>> - dropped inhibit()/uninhibit() driver callbacks (Hans)
>> - split ACPI button patch into taking the lock and using the helper (Rafael)
>> - dropped the elan_i2c conversion
>> - fixed typos in exynos adc
>>
>> v1..v2:
>> - added input_device_enabled() helper and used it in drivers (Dmitry)
>> - the fact of open() and close() being called in inhibit/uninhibit paths has
>> been emphasized in the commit message of PATCH 6/7 (Dmitry)

<snip>

> 
> The entire series looks good to me:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

What are the prospects of this series being merged?

Regards,

Andrzej
