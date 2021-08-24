Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB03F63C1
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhHXQ6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 12:58:06 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37837 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhHXQ5f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 12:57:35 -0400
Received: by mail-ot1-f43.google.com with SMTP id i3-20020a056830210300b0051af5666070so38110590otc.4;
        Tue, 24 Aug 2021 09:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C7txPjPjbsp8XuclaI5qbJQ3gQnsw2SWCgSeRaywFZQ=;
        b=iK0W/8PnK9hFYuFlFcy4yOhQKan4jlYuto9nlV1RRWFYp6V6lpSdUivvG7atz1qPr1
         eKGPZSuqJlE5CfaPzPIahN9mM3HfFzmp3o9XQdGSjDYzrz/Gc+jIHcfJ4terBWz312ID
         jLeWV4T+3C7LPgjYfz8sP5eKHMwMF8xk5rjDFBYYc1MfR3kjJZqoyxDHnEdljegmV9k2
         5YIDqq6ujvTdrbStSPv43m08DFgX/9JPj4i56zngz7nyn/tgRHFNNwj+A0F4Hsgm0Zej
         /eejXMKkFlIduNvE3o28F1p7Jmm9RbQJFU9jU+3/VO12c31r6xC2IcuVunVG5rHmmHaO
         bsew==
X-Gm-Message-State: AOAM532fkw7A/AatSQ8jEB6Syglo8K2wVzmp/rEDUgGXll0RAcwCSs6V
        H3btaeXmNouAga5VK9e9HA==
X-Google-Smtp-Source: ABdhPJzkiNL6iSxtcJl9nTdq2oHs5KYVn1yCRary5Wk5G/v93BTTPpM9RS39MpM82OuagU7zLghLfw==
X-Received: by 2002:a05:6830:156:: with SMTP id j22mr25337495otp.75.1629824211300;
        Tue, 24 Aug 2021 09:56:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n13sm2971351otr.11.2021.08.24.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:56:50 -0700 (PDT)
Received: (nullmailer pid 622951 invoked by uid 1000);
        Tue, 24 Aug 2021 16:56:49 -0000
Date:   Tue, 24 Aug 2021 11:56:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     ardeleanalex@gmail.com, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: temperature: add MAXIM max31865
 support
Message-ID: <YSUk0eiz0ETc1J8W@robh.at.kernel.org>
References: <20210824050650.72619-1-navin@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824050650.72619-1-navin@linumiz.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 10:36:50 +0530, Navin Sankar Velliangiri wrote:
> Add DT bindings for MAXIM max31865 RTD sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> 
> ---
> Note:
> Changes in v2:
> 	-> Changed the name RTD to Resistance Temperature Detector
> 	-> renamed maxim,no-of-wires to 3-wire
> 	-> fixed code alignment for the example
> 
> Changes in v3:
> 	-> Added more information about 3 wire RTD connection
> ---
>  .../iio/temperature/maxim,max31865.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
