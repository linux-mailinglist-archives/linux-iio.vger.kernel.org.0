Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0537A0591
	for <lists+linux-iio@lfdr.de>; Thu, 14 Sep 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjINN3g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjINN3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 09:29:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39C1FD8
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 06:29:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso10591245e9.1
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694698169; x=1695302969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IVYm1sp3o2td+xhAxlg+IpxgQ4XVrkuF0qt5uvcZAo=;
        b=d2ZmZGEjsL6D2Omh04GoHoOS2kXBRDNgo/gRVAC9Su6MAoXTDpytOvPODvcxjsQXms
         rLKRiDZkoDdjAUke/oe6aa9Pkfu5Jq46BdGiTZimlKF8woxpSDthHyfvw/UPRZy0UXB8
         LgkAlXQTkPfWB4Ti3v0rA69+ak5VBlCL9bWtG9nYyLip5Zr2v1wglmyhG8dkuELa4U3m
         hIEFXwCXhOWhP8kuoKvChyzXfQeYGXwapA9sKuM1U88AA2rSPu/kEN5Fu+iSHYRcY0Ej
         D0vq9woyn4NHN7YIkGGWPGC0PODIf2lbD0ylvzxIckqpjcoV/6jIwQQGcmWNLT3FhuSN
         Vhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698169; x=1695302969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IVYm1sp3o2td+xhAxlg+IpxgQ4XVrkuF0qt5uvcZAo=;
        b=oOY9LMGNGdvZxIbLGCiCvNTyWfS/YgChr6CETIFTu8AKLs3LzWCfdrnLxr5ItjBDAU
         2Ck3oJ+7zQTLUjv6arPPzEmW6IJ4ttxz0qojBBkHWymsbCVvuGjTM+DwzWwT1wrNxXao
         L6T/+r6eg5t1WlNqox56Bz8KedsLEQivMXpHubXh0zQ3iLurJk32CMlrCtg9OLoZnvo7
         RRHamE3Ir7XIIr7AIIU4GWA/NDCRaEIFEIqj+My2h0tajsdw9X9K8UNhyPNpIsutZPWG
         Xl4MpB7hNeVWoVp8pSUa3MsmyhQ+nONivFUjchX5/rgZfvblL/ONOc1GqdC/A+8cucUb
         f5pQ==
X-Gm-Message-State: AOJu0YypT0zdrU5rj1ctILp0XoqWfiaetmXW36wq3S0i5nlhumEtyqQ+
        gxZjJ04/Dm25OIwEn4IdR68QkA==
X-Google-Smtp-Source: AGHT+IFsObWxa6Uye6I2xHcb+5RBS4O/yaABXX1i+bkbNgPTwdEq/RDteFy7PsDLxxtbhGAktOn0EA==
X-Received: by 2002:a1c:ed0d:0:b0:3fe:238e:b23b with SMTP id l13-20020a1ced0d000000b003fe238eb23bmr4421897wmh.36.1694698169527;
        Thu, 14 Sep 2023 06:29:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003fc0505be19sm1976128wmc.37.2023.09.14.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:29:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 16:29:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Marius.Cristea@microchip.com
Cc:     linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: adding support for MCP3564 ADC
Message-ID: <a1e72a3e-e4a7-4319-863c-28ac3b6fbe41@kadam.mountain>
References: <5ba16a5c-71aa-4dc1-8be6-320750d10b73@moroto.mountain>
 <b936e5cf-fcd3-421b-917a-5673df02f631@kadam.mountain>
 <2d35a8d374dfd68c9c85fab2ec552555b1343a09.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d35a8d374dfd68c9c85fab2ec552555b1343a09.camel@microchip.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 14, 2023 at 01:19:33PM +0000, Marius.Cristea@microchip.com wrote:
> Hello Dan Carpenter,
> 
> 
>   Thank you for your feedback.
> Indeed, it will not add more information in this case so sure I can
> remove that line.
> 
> Please, tell me how it is best to procced next: submitting another
> PATCH (V6) in this case, or to create a Fixes to the PATCH_V5?
> 

I believe that you should send a follow on patch instead of sending
another rev.

regards,
dan carpenter

