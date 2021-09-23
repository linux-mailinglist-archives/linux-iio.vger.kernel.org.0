Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C05415E98
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbhIWMna (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 08:43:30 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42968 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbhIWMnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 08:43:21 -0400
Received: by mail-oi1-f180.google.com with SMTP id x124so9434466oix.9;
        Thu, 23 Sep 2021 05:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KG4pqRTbZiSxeF9UzbCNdTXffoBAP6x2dhHFJLQTFSg=;
        b=kyT/pM3HNOsak5HvOUJWxDSFLk2PqdR50saRfH/dpg0QNexJTRdLiTlUw99GagPuDV
         Y94Y9sAE9JKbKSIza25xJPiClYG8hM/IlkmjRe+Wuaaf/mrNytde6uIIv6Zqz221ok3N
         55ZiuZtY2kPgsyCR0xknAYoCBLAGqoE7Wv0HGwBDlt8Wov1PEQNlN5NYCHY0bgc929RU
         7AGiGZYUDyKjkNdaHMksJYGXpuGYhDfXm6auoem74RR69yq4+neyD+eyXttm+tY/TwpT
         ZeDEAeIafB78h8VLp+kxE2ZCGV4cIf5X3EV7Ljqt3cWp2xasRsDcwMli4TzOTGO+22PO
         v+jA==
X-Gm-Message-State: AOAM530rmcicBcaXnqVm+jiAS1wYnX2wy4v8o4GUbpfyOAHBPcE94g+f
        109dDXmdV6T5CTX2v2k+E4QbKJ152g==
X-Google-Smtp-Source: ABdhPJzpvygmxfnppFk2EvQsbK6e8v1Nf9zyIv0ZPZVH1OD8OeLYHlWQqh0LsFCJ0ZLrHcSI2Ty7DQ==
X-Received: by 2002:aca:c641:: with SMTP id w62mr9392577oif.102.1632400909768;
        Thu, 23 Sep 2021 05:41:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i4sm1259115otj.9.2021.09.23.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 05:41:49 -0700 (PDT)
Received: (nullmailer pid 2817731 invoked by uid 1000);
        Thu, 23 Sep 2021 12:41:48 -0000
Date:   Thu, 23 Sep 2021 07:41:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Devajith V S <devajithvs@gmail.com>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: kionix,kxcjk1013: driver support
 interrupts
Message-ID: <YUx2DII/y3FVNF04@robh.at.kernel.org>
References: <20210919203656.119742-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919203656.119742-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 19, 2021 at 10:36:56PM +0200, David Heidelberg wrote:
> Driver has interrupts support, which description was missing in the bindings.

You mean the h/w has interrupts which was missing?

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml        | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
