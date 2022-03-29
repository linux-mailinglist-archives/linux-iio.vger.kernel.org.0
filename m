Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C84EB6D1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 01:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiC2Xfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 19:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2Xfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 19:35:39 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15B255AA;
        Tue, 29 Mar 2022 16:33:55 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q129so20574452oif.4;
        Tue, 29 Mar 2022 16:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H7arMY3hJd0HTecwUFs09VFZUkWN1ZlFL3he77V56ak=;
        b=HdBxmktHE6PdZsppClxi56Qn2TQCVMePC/Ld5nXZvommW5N4cd91dK8eexJD/lWgxw
         zt+j0w13M9usyXIz1TzGOacsSCu+oI2kTG0sV1vYbeEhq02HyAHjVvttP53b3hYUPfrD
         XS0sL/mi+P9k2OMr6YSfSpOCCWMNbN2cuKThPKMpV9IwouiHmOOsmQvlSGYlaq/Vu+Z+
         Gv8pnPs/akPHnPu0jox5lBQ7k7i6vteHrWpEAh9bswpX6IMr5W5OSQhQ/3fHMzUrOSw5
         p6KL3ZZJrjfxtmlJYC6m2MibPhGwe7Ch8jSA9YAjUoa9PA0OzPTIW3NGd65+mHmQXDBP
         hU1A==
X-Gm-Message-State: AOAM531xPrDknsVMHB5OTOguccq+3QfOP1Hlei0a32Af7qyqlmL3+wTt
        W5T0HiZGpCqLotg6J0478g==
X-Google-Smtp-Source: ABdhPJwtmgLyexHaiFDHaenDpJeCF51b3L+FWVvNnJrQRa3vBeiwSWz6yk6MPMG2Ys8M/hGyzEm7ZQ==
X-Received: by 2002:a05:6808:198a:b0:2da:59cd:46c6 with SMTP id bj10-20020a056808198a00b002da59cd46c6mr660007oib.75.1648596835219;
        Tue, 29 Mar 2022 16:33:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a9d6f06000000b005b266e43c92sm9423688otq.73.2022.03.29.16.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:33:54 -0700 (PDT)
Received: (nullmailer pid 1565669 invoked by uid 1000);
        Tue, 29 Mar 2022 23:33:53 -0000
Date:   Tue, 29 Mar 2022 18:33:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        swboyd@chromium.org, jic23@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 3/8] dt-bindings: iio: sx9324: Add precharge resistor
 setting
Message-ID: <YkOXYaxTUrjYkm/h@robh.at.kernel.org>
References: <20220325220827.3719273-1-gwendal@chromium.org>
 <20220325220827.3719273-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325220827.3719273-4-gwendal@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Mar 2022 15:08:22 -0700, Gwendal Grignou wrote:
> Allow configure the resistance used during precharge.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v2:
> - Change kOhms into ohms.
> 
> Changes since v1:
> - Suffix field with kOhms unit.
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
