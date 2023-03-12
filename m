Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6168E6B67BB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCLP5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCLP5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 11:57:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DC460B1;
        Sun, 12 Mar 2023 08:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 185A5B80B50;
        Sun, 12 Mar 2023 15:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633C0C433D2;
        Sun, 12 Mar 2023 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678636628;
        bh=fyh667Lxz9Ni4noa2bDDew99E/LzPY5F3qTsCwlXaW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy8OYD8svYoJG5WyetYk5zSR7M2nLak/Euu/fJ029YHjDteT2Gr+7FwmO9LMBfEFa
         rHd8MUUVWil5F709y5bt/d5umC/Mk0YAq2lWgTdK//+d3Pwyp+ff9n7o9XUb5AhVQv
         auYShgXGUgBuY37JzeN40TpH+IY0HFWYdHikTgUarSVKeKLwJClhc0hNPZuk0n9EIy
         q/e7Fcl4/b7Xw7bFDs0b3WurbLVQULmFQ14MrKsgTJSder/qJFnsNH8PPswb8L6uvD
         KFJDbYTBe7BiEOMld6qASKvbGhejwQT8MA0KYBPLdGmuuqFE7v+SartUudtgVXfKuD
         jx3EaNCyNA3CQ==
Date:   Sun, 12 Mar 2023 15:57:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb
Message-ID: <20230312155714.7ef33aaf@jic23-huawei>
In-Reply-To: <ZAmtbGfUJiH5gSIY@lore-desk>
References: <cover.1678100533.git.lorenzo@kernel.org>
        <fecf1f20cc8e99fb8654cc733f14bd449ca7f87a.1678100533.git.lorenzo@kernel.org>
        <f2bbda1a-b6e3-ccbb-d77a-8bdb42aca0ee@linaro.org>
        <ZAmtbGfUJiH5gSIY@lore-desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Mar 2023 10:57:00 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> On Mar 07, Krzysztof Kozlowski wrote:
> > On 06/03/2023 12:08, Lorenzo Bianconi wrote:  
> > > Add device bindings for asm330lhb IMU sensor.
> > > Use asm330lhh as fallback device for asm330lhb since it implements all
> > > the features currently supported by asm330lhb.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > index decf022335d8..b39f5217d8ff 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > @@ -46,6 +46,9 @@ properties:
> > >        - items:
> > >            - const: st,ism330is
> > >            - const: st,lsm6dso16is
> > > +      - items:
> > > +          - const: st,asm330lhb
> > > +          - const: st,asm330lhh  
> > 
> > You added it to the end of the list, but aren't there any ordering
> > already? If so, it should be put rather in correct place.  
> 
> Hi Krzysztof,
> 
> I do not think there is any ordering issue there.
As of today, they aren't in any particular order that I can see.
However, it might be nice to go for some sort of order as a follow up patch
(very low priority though!).

The same applies in the driver, where some of the entries could be organized
by name or maybe wai value.  Perhaps it's just not worth bothering and this
series doesn't make things worse, so I've applied the series to the togreg
branch of iio.git and pushed out initially as testing to let 0-day
see what it can find.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > 
> > Best regards,
> > Krzysztof
> >   

