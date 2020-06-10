Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018631F4AD9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 03:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFJB2O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 21:28:14 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40293 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFJB2M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Jun 2020 21:28:12 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49hTrh691xz8r;
        Wed, 10 Jun 2020 03:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591752489; bh=GKakFZj7r0PwB6e2LKfOoZiiZ9swBqGVdyd905VRjjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcyUlr+WvHTHmVp9QAURy3vHUtHVVvuUk1Xc6U+oronaswAv4sPlpbwXkVXPI8OAh
         +ZCIKP6b32XkKvBIkcDKfm7t5TkDfmLGkNf74ukWIjaGqoW7qPfkxtWoih0Eomc4q/
         w2zgsXY6Ruhf8XUqJzx4KoGN+dBRlxxN21IxsSv4ms6v4OXw8WDPGKcSmtcRlDrzu+
         SXD6KNjcaDfhF9rBu5rWcpoycCx3SX/hJ8Ihse3BcYOPhIiNqNAicuPBIwHgj3I9AF
         SpBhhg7k+AJoi+ZsRdKBumYPce06a6uaA4FP/36CK0TBm0UvejlWb02cPOjzHiUszs
         CUzBf4na9/iZw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 10 Jun 2020 03:28:01 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
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
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com
Subject: Re: [PATCH v4 5/7] iio: adc: exynos: Use input_device_enabled()
Message-ID: <20200610012801.GA11530@qmqm.qmqm.pl>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <20200608112211.12125-6-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608112211.12125-6-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 01:22:09PM +0200, Andrzej Pietrasiewicz wrote:
> A new helper is available, so use it. Inspecting 'users' member of
> input_dev requires taking device's mutex.
[...]
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -633,7 +633,9 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  	bool pressed;
>  	int ret;
>  
> -	while (info->input->users) {
> +	mutex_lock(&info->input->mutex);
> +	while (input_device_enabled(info->input)) {
> +		mutex_unlock(&info->input->mutex);
>  		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
>  		if (ret == -ETIMEDOUT)
>  			break;
> @@ -651,6 +653,8 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  		input_sync(info->input);
>  
>  		usleep_range(1000, 1100);
> +
> +		mutex_lock(&info->input->mutex);
>  	}

Missed an mutex_unlock() here.

>  
>  	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));

Best Regards,
Micha³ Miros³aw
