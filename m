Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5996E53D7AA
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbiFDQPA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiFDQO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810882F39D;
        Sat,  4 Jun 2022 09:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCF960EB0;
        Sat,  4 Jun 2022 16:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C806C385B8;
        Sat,  4 Jun 2022 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359295;
        bh=YNBOdki0MPCe6fJMuZ/Zne8pINv4RDjanwRX9bAOXqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQUR/ZEbuNhS4i71M7FdmPzMpicH9b7eaGMoKFSysv/9pwlJK73uTfn1pBB10ZOJN
         anD9+0DOOQGO/yr+LNGLQd9autlOOxCq0XIG21FUlBf0TLwAhdYaucRBN1st9mIusG
         saIuuRfgi3Aylqv0h6wElUqh2p0upUcOWmrKrxEujaPbQ+A2N5g9g0g9V4ocCqb/cE
         osJs9nfEsogBCNOWy9WIj2GNSkyikai1NHtJbUsI+3fxvIE7+yoswc8O5LNIQ0pOUJ
         pBmdfNfXJxlLDjiXH4+RvUjPIwH6vL3u32qgU+445J9tNWXATvNtfcVlkvVLSuh1sT
         N7EfCpB8UWaig==
Date:   Sat, 4 Jun 2022 17:23:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/10] dt-bindings: iio: sx9324: Add input analog
 gain
Message-ID: <20220604172357.6621e674@jic23-huawei>
In-Reply-To: <CAPUE2utjhjLiXyASp5kuM9E67xeKztjtH6JJxNzGqtv3anaafQ@mail.gmail.com>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-8-gwendal@chromium.org>
        <20220501181741.5dd3bf26@jic23-huawei>
        <CAPUE2utjhjLiXyASp5kuM9E67xeKztjtH6JJxNzGqtv3anaafQ@mail.gmail.com>
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

On Mon, 9 May 2022 22:48:26 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sun, May 1, 2022 at 10:09 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 29 Apr 2022 15:01:41 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  
> > > Allow setting the configure the input analog gain.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> >
> > Hi Gwendal.
> >
> > So, my immediate thought on this is whether it make sense as a
> > dt controlled thing or not. It's the sort of thing hardwaregain
> > is for in the userspace ABI. However, I see that's already
> > in use for the digital gain. This one also unhelpfully applies
> > to all changes whereas the digital gain is pair wise. Hence
> > there is basically no way we can map the two controls to a
> > single ABI element.
> >
> > So, how would we expect a board designer to set this value?
> >
> > If the answer is we basically have no idea but some boards do
> > want it set then I'm fine with this basically being a somewhat magic
> > value that is in some vague way associated with the antenna setup...  
> More or less :-). All these parameters are set with the help of
> Semtech application engineers. The input analog gain is directly
> linked to the antenna design, as it is used by the AFE (Analog Front
> End). The hardwaregain (aka digital gain) comes second during the
> digital processing. We could have put all the settings in the device
> tree, as we don't expect changes once the values are satisfactory to
> pass regulatory testings, but the hybrid approach still allows some
> tinkering: I've use to get a sense of the data amplitude when
> collecting data with /dev/iio:devoceX.

Fair enough. Applied,

Thanks,

Jonathan

> >
> > Jonathan
> >  
> > > ---
> > > New in v5.
> > >
> > >  .../bindings/iio/proximity/semtech,sx9324.yaml        | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > > index 0be87ac05b97a..d265eb5258c84 100644
> > > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > > @@ -143,6 +143,17 @@ properties:
> > >      description:
> > >        Pre-charge input resistance in Ohm.
> > >
> > > +  semtech,input-analog-gain:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 3
> > > +    description: |
> > > +      Defines the input antenna analog gain
> > > +      0: x1.247
> > > +      1: x1 (default)
> > > +      2: x0.768
> > > +      3: x0.552
> > > +
> > >  required:
> > >    - compatible
> > >    - reg  
> >  

