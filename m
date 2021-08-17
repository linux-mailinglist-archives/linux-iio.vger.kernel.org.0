Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927403EF4AB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 23:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhHQVKw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 17:10:52 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45705 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHQVKw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 17:10:52 -0400
Received: by mail-oi1-f169.google.com with SMTP id o20so1114105oiw.12;
        Tue, 17 Aug 2021 14:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CTgAmphwn1ois5hk55721DjpVa/iUWBOuHd03LxTkuI=;
        b=ZOcrqW4ezSW4DUG9aBS0k+fgtEzsOG5Ix/PL6ZP/F14vyJ0buIn9HPrdOJw1Ga33CN
         aRKYMXIDfBxwhUUFlh2yld2tAUvHXY1jG67JjvrqtyFuG/mRwQlmQP0aZF34xFEAbTwa
         4tns1FVH6Bckw9XYQXvsz5gEk0zz/CZvW+qFj8qDgG2MBiEMNjlIeBtWvtcP04YqRKL7
         94joExLy8cR+hOX52dYl5b4uBJigSv11DYv3I6MTG743LESQ923RE91TOS1C/1Pt8umm
         pJKJ7ED+NUHkfFc9QUZGp4WZ4KfjjGzo4qL03soes9IMPi0Gk6BPOcPEs6MVJhq84JzY
         cImw==
X-Gm-Message-State: AOAM532WSL/hirLU7X1NXweT2YnoX+6ytTa5L5EHfayvf5tc3sAVyEfJ
        FX3MTP1/hY/Oh1E6I5BfMQ==
X-Google-Smtp-Source: ABdhPJx++Rc1EBvfd+6pazZap11v9ifQAF3Fq1/XdEIekbI/RB092ivcdK5zyZaRny/3CY02mBYkMw==
X-Received: by 2002:a05:6808:1415:: with SMTP id w21mr4115989oiv.140.1629234618442;
        Tue, 17 Aug 2021 14:10:18 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l16sm615679ota.55.2021.08.17.14.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:10:17 -0700 (PDT)
Received: (nullmailer pid 844799 invoked by uid 1000);
        Tue, 17 Aug 2021 21:10:17 -0000
Date:   Tue, 17 Aug 2021 16:10:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     devicetree@vger.kernel.org, Dragos.Bogdan@analog.com,
        lars@metafoo.de, jic23@kernel.org, Darius.Berghe@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v12 1/2] dt-bindings: iio: accel: Add DT binding doc for
 ADXL355
Message-ID: <YRwluQS5Zr11ngE4@robh.at.kernel.org>
References: <20210811073027.124619-1-puranjay12@gmail.com>
 <20210811073027.124619-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811073027.124619-2-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Aug 2021 13:00:26 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
