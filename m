Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B46A516687
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiEARPa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiEARP1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 13:15:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214552B15;
        Sun,  1 May 2022 10:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F6DB80E94;
        Sun,  1 May 2022 17:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04242C385A9;
        Sun,  1 May 2022 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651425119;
        bh=KZhKGIXK9KM4ngC25lCnqXyXkUV5rp0+lhxc+16wgWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R8pi/ChuFBvfHItTx5ZsX3otgXT0x0cDZpYcraQZ/i+Z4VkcHgUHyEkFMv44dElJT
         /XQfW64j2ayPAIcdqN0WlJDGrGlrxUllNlr/SSSGqGhkAsXWRIyq5pgDo3ldqUgeS5
         54XUT7/QaVD61w1KeYA/kwo7WRwYcRIX3jqg5Dio75XYjA4Q/0rFZoFSdM91qOTedI
         pmmBZcYaB56LIV+yjaKa30bt2eWPpkWMlXbxRLf56zQFqQASOGIRWL5o9Xloa+6uG0
         v0bGyFiINIkkeqB7Eqxz0EYQCQTevHFvCHYz6pWfunqx8UWWUog+WLjp8HpAxnHBiO
         zZtWCp7fd1Afw==
Date:   Sun, 1 May 2022 18:20:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/10] iio: sx9324/9360: Add settings for precharge,
 gain and internal resistor
Message-ID: <20220501182015.5d4fe2b9@jic23-huawei>
In-Reply-To: <20220429220144.1476049-1-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 29 Apr 2022 15:01:34 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> For Semtech sensors SX9324 and SX9360, allow confugration of the
> pre-charge resistor (9324/9360) and internal resistor (9324).
> 
> Fix register name spelling mistakes first and set default value properly
> for sx9324 internal resistor register.
> 
> The 9360 changes are independent from the 9324 changes, but they are
> very similar.

Other than the question I raised on the analog gain patch and
the need to leave time for a DT review of the last couple of 
binding patches, this looks good to me.  If it looks like that
might take a while I might pick up the first 6 patches without
waiting for the last 4.

Thanks,

Jonathan

> 
> Changes since v4:
> - Add analog gain setting
> - Add missing test when property is not found
> - Fix dt-schema errors.
> 
> Changes since v3:
> - Rename reserved field as _RESERVED_
> - Fix invalid string matching with match_string()
> - Fix cut and paste error in device tree bindings.
> 
> Changes since v2:
> - use -ohms instead of -kohms, as ohms is a defined unit in
>   dt-schema.git dtschema/schemas/property-units.yaml
> 
> Changes sinve v1:
> - Add kOhm Unit, add a new patch to fix invalid register setting.
> 
> Gwendal Grignou (10):
>   iio: sx9324: Fix default precharge internal resistance register
>   iio: sx9324: Fix register field spelling
>   dt-bindings: iio: sx9324: Add precharge resistor setting
>   iio: sx9324: Add precharge internal resistance setting
>   dt-bindings: iio: sx9324: Add internal compensation resistor setting
>   iio: sx9324: Add Setting for internal compensation resistor
>   dt-bindings: iio: sx9324: Add input analog gain
>   iio: sx9324: Add Setting for internal analog gain
>   dt-bindings: iio: sx9360: Add precharge resistor setting
>   iio: sx9360: Add pre-charge resistor setting
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 30 +++++++++
>  .../iio/proximity/semtech,sx9360.yaml         |  9 +++
>  drivers/iio/proximity/sx9324.c                | 66 +++++++++++++++++--
>  drivers/iio/proximity/sx9360.c                | 15 ++++-
>  4 files changed, 114 insertions(+), 6 deletions(-)
> 

