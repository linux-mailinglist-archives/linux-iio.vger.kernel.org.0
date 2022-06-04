Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8861253D7AF
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiFDQQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFDQQS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:16:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C502F3A4;
        Sat,  4 Jun 2022 09:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64912B8069F;
        Sat,  4 Jun 2022 16:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57795C385B8;
        Sat,  4 Jun 2022 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359375;
        bh=vXN9fGHy1Spy0IWewHKdWV1rokLGkkpqBsOynW7Ucfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkS1G/T9qhAeQ95P7a9YRuFU1Xi0E2xweyw+gf1upyA2l5XSt2+hikr5vfspBhQ/h
         +8fzh6Ti42z5Ou360S+lLBKe/gqstOssO9v71Ka560xUCk8R0YBauT7wQAC7OXHKJf
         dzb4DYBF2CYL2h+nNsOMcL6b5Qkw/SyoGZ8Sl9O5ibiqP2TkgXhJEdBHeZ15rTt1Ai
         vncKUp31WTJEoo2gJim3SeKXev/nFC+sRtbLUyjGe6useQcOdpX02fgZ2lleAjJLEn
         GaMR2TrHBQg9443P7S1P/rzRelVoTgsymPad5t8omevkN7vexHo+2HONDAqAm3yRVx
         7er4/wWD6rUpA==
Date:   Sat, 4 Jun 2022 17:25:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, swboyd@chromium.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v5 09/10] dt-bindings: iio: sx9360: Add precharge
 resistor setting
Message-ID: <20220604172516.27fe389f@jic23-huawei>
In-Reply-To: <YnFuVfurEsrYxFdE@robh.at.kernel.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-10-gwendal@chromium.org>
        <YnFuVfurEsrYxFdE@robh.at.kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 May 2022 13:03:01 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, 29 Apr 2022 15:01:43 -0700, Gwendal Grignou wrote:
> > Allow configure the resistance used during precharge.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > Changes since v4:
> > - Add multipleOf propery
> > - Move description at the end, to match convension.
> > 
> > Changes since v3:
> > - Fix maximum field. Check make dt_binding_check passes.
> > 
> > Changes since v2:
> > - Change kOhms into ohms.
> > 
> > Changes since v1:
> > - Suffix property with kOhms.
> > 
> >  .../bindings/iio/proximity/semtech,sx9360.yaml           | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied,

Thanks,

Jonathan
