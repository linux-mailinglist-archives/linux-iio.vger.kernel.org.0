Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4B4EB6D3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiC2XgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 19:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2XgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 19:36:00 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CD255AA;
        Tue, 29 Mar 2022 16:34:17 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so20462271fac.7;
        Tue, 29 Mar 2022 16:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSxTgnAMCI7vmbbcdIljN/DgZKTIPgLyYoA5Vei/bqM=;
        b=NVYnxMmdzpnN+idk+xJ6JNUzFKkyqzztmAfkb9TG7fspU0rfUojDy1d98ucOmsD6D6
         VX1nm2p5Rvv1y5if3yVk1jwN5hIk0waqnbULr0RHAaoxLQQzitmSKQoi8enapoZyZ/Sj
         kIsvvZPUwP8CaA9Kugth6bWnCVSXlQ7TO/SscHOo/sTjAXVza6rar/kwg+mYr3zFBDi0
         dmhbNQR20XKRulJqFH+KjnrRqQmWW+s278kiFL2PWaFYNTIhebs2/01ayCK+aQdEfbZn
         Q+berYbzibopIQ62E3HXyYznzvCoIaWJ+UZzhug4TC5N10csTaK2L0K+v7SHv5HG+o7U
         khFA==
X-Gm-Message-State: AOAM530TUh5dAH0/cQQZX1qOlI2apBn1Pt74kbVwkUlWrALBgAlMYQGB
        OfpIcBbhD08aj+YmUOCaNw==
X-Google-Smtp-Source: ABdhPJwmXobqoUaBz1u4a77OQtVBAI3/c82CiHLeM4RVqgXYsJXOPKSHoSwnsljHy0UixkW/cr1BUg==
X-Received: by 2002:a05:6870:b402:b0:d3:3712:efa7 with SMTP id x2-20020a056870b40200b000d33712efa7mr872012oap.88.1648596856701;
        Tue, 29 Mar 2022 16:34:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d22-20020a05680808f600b002f765ae431bsm1401435oic.4.2022.03.29.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:34:15 -0700 (PDT)
Received: (nullmailer pid 1566437 invoked by uid 1000);
        Tue, 29 Mar 2022 23:34:15 -0000
Date:   Tue, 29 Mar 2022 18:34:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jic23@kernel.org, swboyd@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: sx9324: Add internal
 compensation resistor setting
Message-ID: <YkOXdxBGSC6PCZ08@robh.at.kernel.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
 <20220325220827.3719273-6-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325220827.3719273-6-gwendal@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Mar 2022 15:08:24 -0700, Gwendal Grignou wrote:
> Allow setting the internal resistor used for compensation.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v2:
> - no changes
> 
> Changes since v1:
> - no changes
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
