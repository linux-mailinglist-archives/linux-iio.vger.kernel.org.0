Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC16814CD
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 16:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjA3PVw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 10:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbjA3PVn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 10:21:43 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA883144AE;
        Mon, 30 Jan 2023 07:21:39 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-163ba2b7c38so3548699fac.4;
        Mon, 30 Jan 2023 07:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NSVbX4xHtQYGwioMq/aOSnTwyPJzXFq/h73uH9NB58=;
        b=XE/OIykMgkxMGgZr95f5ZQo6/q5VLWOvrZrPYtYvdGccYpaIae8F+ajz+YggbAG5+m
         HLbOYK5T1Wg4AvmUzpLVm7V15mB5xxTw7nno63T6Ssrwn7ifGIkTgk+MGBxvYeQiUxLm
         b3SMJJ0O3F8L9KoR02IoUmX6g5qLqKN0SNYyFl26eQGfKfq8xA02zy5IOl8oBQpfJHD7
         Tf89xkk7EWVWX8Fb3BxjZP/M5NGbUQsw3LReuGTs7Y0wmGrEc0RuMMoxiSPiw3Osi8ii
         eUQ795NKsY7YTlEkTZWDLaMC3YJMX2m4ED8YXPLdLRwFnCXP4C5WeN1oFgar0vmZB3IV
         PbdA==
X-Gm-Message-State: AO0yUKWOC+Gu5njiezZ1YHNg+jR5N19Z4Ty+c5fyrRsoJcU7DF1RfCO/
        BF2+jra9mNjVho9n8YrR+g==
X-Google-Smtp-Source: AK7set/N/oWpOD2zj/Ao8+Acld2pqQriPDXeQfaJ8xvTcw6Mso9QuCrB/QnwVsosMUZbS+c4r1bHWw==
X-Received: by 2002:a05:6870:a9a1:b0:163:74ae:e3a6 with SMTP id ep33-20020a056870a9a100b0016374aee3a6mr5931238oab.1.1675092098885;
        Mon, 30 Jan 2023 07:21:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e12-20020a4aaacc000000b005177543fafdsm1518739oon.40.2023.01.30.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:21:38 -0800 (PST)
Received: (nullmailer pid 2667528 invoked by uid 1000);
        Mon, 30 Jan 2023 15:21:37 -0000
Date:   Mon, 30 Jan 2023 09:21:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: iio: accel: Add ADIS16203
 Inclinometer
Message-ID: <20230130152137.GA2586655-robh@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
 <20230129155602.740743-13-jic23@kernel.org>
 <167502679603.787347.16663590794832817182.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167502679603.787347.16663590794832817182.robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 30, 2023 at 07:35:26AM -0600, Rob Herring wrote:
> 
> On Sun, 29 Jan 2023 15:56:02 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > There has been a driver in staging for quite a while.
> > Given we are now moving it to the main tree, time to make sure it
> > has binding documentation.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > V2:
> > - maxItems/minItems added where needed.
> > - fix interrupt-names to allow multiple entries.
> > ---
> >  .../bindings/iio/accel/adi,adis16203.yaml     | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.example.dtb: accelerometer@0: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml

I was scratching my head on this one... Check the compatible string in 
the example. You've got 201 instead of 203.

Are these parts that different?

Rob
