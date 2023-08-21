Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA7783434
	for <lists+linux-iio@lfdr.de>; Mon, 21 Aug 2023 23:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHUUhN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Aug 2023 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjHUUhM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2023 16:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBCC7;
        Mon, 21 Aug 2023 13:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE4D63B7E;
        Mon, 21 Aug 2023 20:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509F7C433C7;
        Mon, 21 Aug 2023 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692650230;
        bh=X7Bms6M8oLw/coJIxa4RAToyJCbMhPrTfEm4sthOme8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfcaiGvEPaIg7Hxv3qMsyY247BK2fzPB3AdKqZ/XXXT3L1fcicR3cS9IbOYTAFXK7
         +taaQlDHb6x2k2KU9fViQ78qRwoHLaj9loBNoT8osRnRt46/Elew1B1nfjxlnt05ih
         Ch3/WSVSG9kqTeyn2yyTZVjVTMporWhY3ABd5fg9h41ZfzBIHP0eQRthB1QkhXe5b/
         OauJ2ctERZFZ1yp/ULOFWbQTI0r63JPuhFugymqpP0GowCz7nfFcFs4sy75sWoi9lQ
         vqebub51XjJmw2lC9fXSIHKPuyjIGnvy+SPnx41wTtB4RK7XourwuKRLvM3PZQW/7s
         aq2FH+1IrhUzg==
Received: (nullmailer pid 2252304 invoked by uid 1000);
        Mon, 21 Aug 2023 20:37:08 -0000
Date:   Mon, 21 Aug 2023 15:37:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: magnetometer:
 asahi-kasei,ak8975: Drop deprecated enums
Message-ID: <20230821203708.GA2250389-robh@kernel.org>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 08:55:58AM +0100, Biju Das wrote:
> Drop deprecated enums from bindings as it is been here for a long time.

Would be good to have "long time" defined as Geert provided.

> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2:
>  * New patch
> ---
>  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 7 -------
>  1 file changed, 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
