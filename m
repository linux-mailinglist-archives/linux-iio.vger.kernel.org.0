Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70F27A02A3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjINL3P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjINL3O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 07:29:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116611A5
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 04:29:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso722227f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690948; x=1695295748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BByK3tfc6PUbDwCOEaXXr3ISJ4Vq9CFVyzLm4t+uio=;
        b=L74vR5Z8pM35AbBoodWcn7UboHsrCPODJyPCQVk5hrPTW73J0r5r71/JktlzxQT2ZZ
         LqSTxljfuBz1829rT1JFz2iEWuxcUQg3LRGqw3nJPp/VyIGlQXrJ3EYPMyAJoAMa7/Id
         gK4jV71n2e8ZTA7ege5OXekbucCyRVgibLHpG/f5v4BvlwH/+mkqLjRIQ4na2oJtZSnN
         SxwRuqLlbnRWJODEA3n4n4PzVZ1FPl+ihpB8HPAC7WFU6wKvAEORLxf558urcRUrnGRu
         9xYj6spmqge90ztSmVO+MjdtLqv8EThTzy80+djxhxTKv+LnDGktQ86eQ8yGtTjxBIJ5
         79xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690948; x=1695295748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BByK3tfc6PUbDwCOEaXXr3ISJ4Vq9CFVyzLm4t+uio=;
        b=OSGAiGX6eVJALl65TwwJQi2RV/DGZ1EAZCt8XSbDkV5t6uh1yhXb5WkvT/8gXE2Uqf
         Yo2trjKhIx7K2i47Q/k5dn8BdR8nP/xV0vb8Rk9C3ntrVuSiHevkWU0fYt4mltTYAHqH
         /5x74Z7ZvDjuxQ/oDucrhEFx4wAFmC5XBZ8HDj6HqGEsK3+ONs3+n/ec8bZ6dGNh0jJn
         fU+QdICaJ7uE0iXuzmeH8/ZD9TbTN6GY60yOKSl6SC4NCcT+pJmAYM4R5wAp6TWuivjv
         Z4O4zw9KfoOKCAaBdQ8AasFH5LaHzmKOlSEpRaTdXiO9gpYKwH4KbTXviIXwQduyW5Bo
         wbrA==
X-Gm-Message-State: AOJu0Yx5/Gd4Gfa3NnlSieYb2DPEf2GfFb1ZaaYuv3lMJCcnwgVod+fG
        MfGrV8S7xeRI1tEcDeJ1raNo1Q==
X-Google-Smtp-Source: AGHT+IHMZzn5BP2AIGJzfT5STy/AkkoqJZEe16UVQpFHRDWuxaUqKWaEoVO567wUnU71eP4MjhwLyQ==
X-Received: by 2002:adf:f6c7:0:b0:317:f537:748d with SMTP id y7-20020adff6c7000000b00317f537748dmr4177351wrp.64.1694690948342;
        Thu, 14 Sep 2023 04:29:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4252000000b0031c5d74ecd8sm1519411wrr.84.2023.09.14.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:29:08 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:29:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     marius.cristea@microchip.com
Cc:     linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: adding support for MCP3564 ADC
Message-ID: <b936e5cf-fcd3-421b-917a-5673df02f631@kadam.mountain>
References: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 14, 2023 at 01:01:02PM +0300, Dan Carpenter wrote:
> Hello Marius Cristea,
> 
> The patch 33ec3e5fc1ea: "iio: adc: adding support for MCP3564 ADC"
> from Aug 29, 2023 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/iio/adc/mcp3564.c:1426 mcp3564_probe()
> 	warn: address of NULL pointer 'indio_dev'
> 
> drivers/iio/adc/mcp3564.c
>     1418 static int mcp3564_probe(struct spi_device *spi)
>     1419 {
>     1420         int ret;
>     1421         struct iio_dev *indio_dev;
>     1422         struct mcp3564_state *adc;
>     1423 
>     1424         indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>     1425         if (!indio_dev) {
> --> 1426                 dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
>                                        ^^^^^^^^^^^^^^^
> This will crash

Actually I think that dev_err_probe() has a check for this kind of bug
so it doesn't actually crash.  The check is burried deep into the call
tree where it prints the name and if the address is < PAGE_SIZE it just
prints the device name as "(efault)".  But it's still not ideal.

regads,
dan carpenter

