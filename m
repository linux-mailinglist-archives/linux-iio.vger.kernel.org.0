Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8915726AD41
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgIOTNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:13:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38467 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgIOTNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:13:19 -0400
Received: by mail-il1-f194.google.com with SMTP id t18so4091452ilp.5;
        Tue, 15 Sep 2020 12:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c59QOoirisEsic0ogk7RbBRwTN0OIjzfefaZGz5P5Vk=;
        b=XSnHihx6TAynwFVd6kyA3lxm0BiPoycAiBRCZZiJeBXMZz2tM36iwSCv8wBatIEkQK
         ciiFiO5QbeTzk6KTIRZKoPIo7k8+H6aU382MCXtAUXGALb2C5sVDSgCZSzC4cplh2V82
         k1Gh3FNyCJjvQmlGdvXgntTTIH/gdvZbDULcxMyBGSu1UsN9E3ghQ5f1yiWs5G+9LLX4
         evk3ig+mx45eHntXf2H4rd/kUNBVNvEB0r7l47oJOgjtR9hzQIipXBREI2Sc+mhEFG3n
         F+tZZCUuYlGBg4xupAvq5UfgS+yG/HMm7z9skBly0C1bhqI8C8vL5jUTFp+D9js+aR1k
         Yfxg==
X-Gm-Message-State: AOAM533FGFoTofz6QtkmDe1zwXKRaWOY7TUy9BgsruvxjAtFyCALXcQA
        6+fCDRxV8cq5Pfc9lV7cbeuKWu0QC5mbuJU=
X-Google-Smtp-Source: ABdhPJyFOJMN/QFZrduUxz6j5c03LrG31nTfJ6FopvvnI5IlNi3Fvy5jGFdnDepBB06GAVl01zDEZw==
X-Received: by 2002:a92:ca85:: with SMTP id t5mr1678583ilo.254.1600197198846;
        Tue, 15 Sep 2020 12:13:18 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i9sm4912947ils.34.2020.09.15.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:13:18 -0700 (PDT)
Received: (nullmailer pid 2333609 invoked by uid 1000);
        Tue, 15 Sep 2020 19:13:17 -0000
Date:   Tue, 15 Sep 2020 13:13:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Phani Movva <Phani.Movva@imgtec.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 13/20] dt-bindings:iio:adc:cosmic,10001-adc yaml
 conversion
Message-ID: <20200915191317.GA2333547@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-14-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:39 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I don't really know much about this one, hence the binding is
> a simple conversion of what was in the txt file.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phani Movva <Phani.Movva@imgtec.com>
> ---
>  .../bindings/iio/adc/cc10001_adc.txt          | 22 -------
>  .../bindings/iio/adc/cosmic,10001-adc.yaml    | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 22 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
