Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E724226C5E3
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIPRVq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 13:21:46 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52261 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgIPRVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:21:22 -0400
Received: by mail-wm1-f52.google.com with SMTP id q9so3537362wmj.2;
        Wed, 16 Sep 2020 10:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=noOG7iKE5pa5+3YZdeRDrD4tO2/FQ7kbCWqQmQ5S6uY=;
        b=kScBXDr5lcCqta/4GkBXm5eb9XFEvf0oKRWou73/R5x6Cb//FIvr+s/mNKBks3Vhzd
         qUu3JGy2Y6bfKZ2YDZRFiB+bvRayF6/o+NQJqHbYhrGUXQSzUTU/u7boW3ZnpllLYxjU
         un2bOGzXWIHEOOOuyf1cMLhiuXqgigQ9/rrpKExMRKFI2Y6h+glU5aWfFvoNAViKesAw
         XiJxT5vbGQH2NBRde5cPYXAN151mNN6dUBKvQU9c/bSViV4ZSh+o6vPHHXdrF//nJPmh
         FnSLmWIW5BSw9/dbxQc4gpWY73z2txRTX3jLizCabwOMaOAqyUgi5/D2Va1jKRFP5Bx6
         Srmw==
X-Gm-Message-State: AOAM531p3oK0vXte82oEXZyignlaDOSbPXBSgaDvDG+SblCQeo4748v0
        Ox+1ndOLsr1baCe9kFFt7N4=
X-Google-Smtp-Source: ABdhPJyCVt6x7GbhkhXsna2T6JCs+t6G7plC2nLF+9+Y8stFEV5cmWuGlKE2ssBPhgwlHWqMHlG10Q==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr5767868wme.18.1600276630256;
        Wed, 16 Sep 2020 10:17:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id a17sm36932683wra.24.2020.09.16.10.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:17:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:17:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 22/25] ARM: dts: s5pv210: replace deprecated "gpios"
 i2c-gpio property in Aquila
Message-ID: <20200916171706.GG19427@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-23-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-23-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:38PM +0200, Krzysztof Kozlowski wrote:
> "gpios" property is deprecated.  Update the Aquila DTS to fix
> dtbs_checks warnings like:
> 
>   i2c-pmic: 'sda-gpios' is a required property
>   i2c-pmic: 'scl-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts | 4 ++--

Applied.

Best regards,
Krzysztof

