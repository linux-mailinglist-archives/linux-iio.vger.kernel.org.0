Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66181F0089
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jun 2020 21:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFETuI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jun 2020 15:50:08 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:41599 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgFETuH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jun 2020 15:50:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49dtXG0LfBz4D;
        Fri,  5 Jun 2020 21:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591386603; bh=nw6ZPbzMEGEU3ympvmvF/EBnKh28J/TObnDHFEogcNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQGk/WcmQdG+yyITewmCzwmMOtBeMJF66LJXev36YPIF5HrC5ZHZ2yLz3vJylFOY2
         WT3VOkjF3kAcjfTkMR4gxIzFUE/sY5FqXj8AFOnZJ4Tr6DOXWsqghWyoTnW+bmLd7W
         jwf7lDWpwE9H61I5VhaqXwCJeCG+3Lg1TEqxk1KZ6vhl2INRouIoCb0udoubFJKGQI
         IsEim/o9vF8TNZ0H+HPzCDx+zT08J5O7Oou9dsj0/dTuOSTcvd1399RdkvL5g6/Eot
         j+wtjmvTFf8Ae7wTPa5xvRXyXIACc/X1FvT/PQI7a7lj4fzSUFS7z0POvlS/mwXhVU
         JIdjeHtEOaibA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 5 Jun 2020 21:49:48 +0200
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
Subject: Re: [PATCH v3 5/7] iio: adc: exynos: Use input_device_enabled()
Message-ID: <20200605194948.GC9553@qmqm.qmqm.pl>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
 <20200605173335.13753-6-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200605173335.13753-6-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 05, 2020 at 07:33:33PM +0200, Andrzej Pietrasiewicz wrote:
> A new helper is available, so use it. Inspecting 'users' member of
> input_dev requires taking device's mutex.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 22131a677445..294715bafe25 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -630,10 +630,13 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  	struct exynos_adc *info = dev_id;
>  	struct iio_dev *dev = dev_get_drvdata(info->dev);
>  	u32 x, y;
> -	bool pressed;
> +	bool pressed, cont;
>  	int ret;
>  
> -	while (info->input->users) {
> +	mutex_lock(&info->input->mutex);
> +	cont = input_device_enabled(info->input);
> +	mutex_unlock(&info->input->mutex);
> +	while (cont) {
>  		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
>  		if (ret == -ETIMEDOUT)
>  			break;
> @@ -651,6 +654,10 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
>  		input_sync(info->input);
>  
>  		usleep_range(1000, 1100);
> +
> +		mutex_lock(&info->input->mutex);
> +		cont = input_device_enabled(info->input);
> +		mutex_unlock(&info->input->mutex);
>  	}

The mutex doesn't really protect anything here, but I would nevertheless
suggest this sequence instead:

lock()
while (test) {
	unlock()
	...
	lock()
}
unlock()

Best Regards,
Micha³ Miros³aw
