Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5F4E1B62
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 13:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiCTMB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 08:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbiCTMB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 08:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F562D8;
        Sun, 20 Mar 2022 05:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E9B60FC1;
        Sun, 20 Mar 2022 12:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F20EC340ED;
        Sun, 20 Mar 2022 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647777601;
        bh=rtknE9wl83YeLcS+jxxy7owVyhePadw4/SffustgzjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SKo5sSulAiVLD2Gr90c9SyqLkGRitvsoF489+2KD7No7TFM3RuZKg2SBxiiDLf4in
         t066/fRFPLxs2ET+f5x0abtzYpvo/Q+oetzntw9bfak3DlEUOCyzT4tcKkQU9GsHqt
         V/u9yFGtntYB8XhuWjk3qc9e3ghRFfJ+rZTPXI2TYfsoR4Q3pMamgXKXKfKRurQlWn
         9jB/YD/9wwIcm1zvWXJwPkwZkuFNMoZCXinEOQMdwzDNSJE370+jLglz3Ue11I8JLS
         3/Un6M9+A1xt/wULQHX1ZgBe6rJVpED9B13MdUZpZWOl6M0g87A80yksuX/FeL3rUV
         AVGZG6isV5CYA==
Date:   Sun, 20 Mar 2022 12:07:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: iio: sx9324: Add precharge resistor
 setting
Message-ID: <20220320120725.13317345@jic23-huawei>
In-Reply-To: <CAE-0n52Lp9-F_DxHrb1aMQaiSU2qpuW6jKCp6qQ8FXyJ87WApg@mail.gmail.com>
References: <20220315173042.1325858-1-gwendal@chromium.org>
        <20220315173042.1325858-3-gwendal@chromium.org>
        <CAE-0n52Lp9-F_DxHrb1aMQaiSU2qpuW6jKCp6qQ8FXyJ87WApg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Mar 2022 13:05:38 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Gwendal Grignou (2022-03-15 10:30:37)
> > Allow configure the resistance used during precharge.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > index b8a6ee16854ff..cd8ed50f2882a 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > @@ -126,6 +126,14 @@ properties:
> >        UINT_MAX (4294967295) represents infinite. Other values
> >        represent 1-1/N.
> >
> > +  semtech,input-precharge-resistor:  
> 
> It is clearer when the units are in the name of the property.
> 
> 	semtech,input-precharge-resistor-kohms

Added bonus is that you won't need the ref if the units chosen
match one of the ones in 
https://github.com/robherring/dt-schema/blob/master/schemas/property-units.yaml

Note kohms isn't there so unless we have an issue representing this in ohms,
please use that instead.

Jonathan
