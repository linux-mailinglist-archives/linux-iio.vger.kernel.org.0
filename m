Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3641303124
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 02:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbhAZBYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 20:24:54 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39823 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbhAYTgv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 14:36:51 -0500
Received: by mail-oi1-f182.google.com with SMTP id w124so16019191oia.6;
        Mon, 25 Jan 2021 11:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Mfcort+Cx9P/ImE6swOSzUGiaClCZE9b0/iAMA9F9Q=;
        b=Ed+4ONi/9BozoSEDk4zDN/HceDnNYUYylrW8KrjkIUJ3/aTHTelLKQGYXSaecpJGQf
         3pzf3ylIsxk38JdtC6OC0dWa5d98qT54O7EhNm1INsp3IqVEyYvS+IBfWbyKPwodq6bR
         /x8CZ5TEKtSJeGMlqg/eR7WUous6j9GsC9P8VjoWJ3QV9Bnp1zIRU7z/UAh7h5eHwSZD
         jaX5Xmgjm8Wix6z9DKEOtmmy3PXXsZF3En8bGipvpNtbCFJ4Umw7USXapoxEEXNxw3Ez
         PV57u4TwWwd/NwQh2V9CAXo1UnNGiGdt6R5IeMSZ9M2UOckTiyM1mV6/KFdjpsGbVOTX
         1MIQ==
X-Gm-Message-State: AOAM531wmrLugZKTI0Z9IYTdOG6B1uLZ6yJ1q/GTVJIKQDO1dxg9AxEM
        Mfpswzco+eHl/F30E5qixA==
X-Google-Smtp-Source: ABdhPJyysfruDxF/asXQAzWaVXtu5DWsOOovw/zNgLHRPd5UvkSk/0vk7PCZ7tysXz5A/csbtH3I6A==
X-Received: by 2002:aca:75d3:: with SMTP id q202mr1082002oic.36.1611603370750;
        Mon, 25 Jan 2021 11:36:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k65sm3670668oia.19.2021.01.25.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:36:09 -0800 (PST)
Received: (nullmailer pid 830149 invoked by uid 1000);
        Mon, 25 Jan 2021 19:36:08 -0000
Date:   Mon, 25 Jan 2021 13:36:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/24] dt-bindings:iio:adc: update adc.yaml reference
Message-ID: <20210125193608.GB829546@robh.at.kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
 <8e37dba8ae9099acd649bab8a1cf718caa4f3e6a.1610535350.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e37dba8ae9099acd649bab8a1cf718caa4f3e6a.1610535350.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Jan 2021 11:59:24 +0100, Mauro Carvalho Chehab wrote:
> Changeset b70d154d6558 ("dt-bindings:iio:adc: convert adc.txt to yaml")
> renamed: Documentation/devicetree/bindings/iio/adc/adc.txt
> to: Documentation/devicetree/bindings/iio/adc/adc.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
