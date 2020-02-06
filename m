Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18E7154673
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBFOuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 09:50:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37268 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBFOuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 09:50:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id v17so6416379ljg.4
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q631zB7rspAWEZ/6z4byLYNG/gSXgdUXdcRN4YlipsE=;
        b=kM8MQPF7VThq9BeFmsSOKWTXz0TYZmed4HUEQQwhSpFI3L5DzsdB7v19MlCykmClY/
         J2xWeXXno3pypyOdkLdgkDrxN+vmm8ky+a6M/zSAcj24J2LS93bCdFxpiR8eitgVUtHK
         9sC4jG3VP8T15Rift2sbIU2dlKAlaHMyqULuT2/XiEsijzlX5etxNuYbZgyWTelKx0Sx
         XHb1gtD2paSbKGBY6O65wAY2dVipCT6ydlVpK95j0WK45e5aQ/YkcVfyRbp3nMRiAUhI
         6+qMzWhwEz+tk0ihV4EWnGb+9RQ4KWoWJzFj66H3Dh8w1OcCTh8Yr8jPdBMFghm2YSV0
         g+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q631zB7rspAWEZ/6z4byLYNG/gSXgdUXdcRN4YlipsE=;
        b=aFvofTvwmDep0RiU+ntJxD/63plyuMA9v5B74E6UbiBV/9MpCbLc0VAHHPolGy6QF8
         Sa6TM5+In8kP1JlETNSfUROidCmO9uY4qfHhGfiTXsdvieGS6pIBX/m0lsJOFCO4pz3v
         6b6xNEihU6sAfZARuDQaF4SOl4/hc+oDWdq3PRLFkV0t+4trdRUEZJqnW+eXWRh3krxE
         1tFggdJU4/6RGsZ39hXTnFg9NRzTPM+FaeiAUWid9sol1hpsP7W2yKLd8we7+7gnPXAp
         s+JRtevn5zta39TVP19grTf9yJLZ7ncvT1hq1JtPYWKGmvMLPfW/xdlZstnvM0amMYm5
         3Odw==
X-Gm-Message-State: APjAAAWKgy1iQnweyXUR33atRwn6+HN3OnKdtKtSM/a/v/uJp4TCigTl
        pz+jAoUgQFf1gAqw4CoGYg2s1awP
X-Google-Smtp-Source: APXvYqzBqR572+ZvG7B43oEU5d4pmBN1FdFYArcbX83ipneK4W+oUJGaviZ6FjSsgL4b20Gp/EfzaQ==
X-Received: by 2002:a2e:9748:: with SMTP id f8mr2371819ljj.178.1581000617541;
        Thu, 06 Feb 2020 06:50:17 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u25sm1481659ljj.70.2020.02.06.06.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:50:16 -0800 (PST)
Subject: Re: [PATCH v4 3/7] iio: light: al3320a slightly improve code
 formatting
To:     David Heidelberg <david@ixit.cz>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-4-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <791299ad-c8e0-a94a-7dbb-780473c8346c@gmail.com>
Date:   Thu, 6 Feb 2020 17:50:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200204093031.616409-4-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

04.02.2020 12:30, David Heidelberg пишет:
...
>  #define AL3320A_CONFIG_DISABLE		0x00
>  #define AL3320A_CONFIG_ENABLE		0x01
>  
> -#define AL3320A_GAIN_SHIFT		1
> -#define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
> +#define AL3320A_GAIN_MASK		GENMASK(2, 1)

Looks like you forgot to compile-test this driver because the
AL3320A_GAIN_SHIFT is removed above, while it's still in-use below.

>  /* chip params default values */
>  #define AL3320A_DEFAULT_MEAN_TIME	4
> @@ -90,7 +89,8 @@ static int al3320a_init(struct al3320a_data *data)
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
> -					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
> +					FIELD_PREP(AL3320A_GAIN_MASK,
> +						   AL3320A_RANGE_3));
...
