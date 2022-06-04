Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE453D7AD
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiFDQQA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFDQP7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0C2F3A2;
        Sat,  4 Jun 2022 09:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B489A60E8D;
        Sat,  4 Jun 2022 16:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B04C385B8;
        Sat,  4 Jun 2022 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359358;
        bh=qoDoOmyO5+MrNmsDm3AMDrrM5lkgrgPAVdA8huG2QU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OjC+y/GLnCOr5jgXzW8h+5/U7Kswejd80PQ8rxtSX8YtnwiqKmsCRJJD1ILNrD70q
         rwoxzg3TmsLIacBgdjO+8kboRpkO42cGRTplJFthvuGHuqf5G4YuSThjNvBtu24Ft0
         JJSeo/lMHL5qEbJu48ireX26IaCoMDkxTs6DRvnEILS4b2Xz/AMk/PB1ZTX8el02/L
         k8KRtMu2svYAXcubjfTnU1JChnCBhGFPljwAGfZc6hWfGiO3dRzyKJ+CXSaY8xVsyA
         Nfc/oj5/qYDuDOtCYwHwzD96pMB143Stc5gpp6XBm8hUQkWkfePG5wythd+9hrgENv
         EqZ5HAg1hAkhQ==
Date:   Sat, 4 Jun 2022 17:25:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/10] iio: sx9324: Add Setting for internal analog
 gain
Message-ID: <20220604172500.2538f34e@jic23-huawei>
In-Reply-To: <CAE-0n53PATjL-w5cWCO1YkCz8oP6jg-FuergskxBd6fsjCMXxg@mail.gmail.com>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-9-gwendal@chromium.org>
        <CAE-0n53PATjL-w5cWCO1YkCz8oP6jg-FuergskxBd6fsjCMXxg@mail.gmail.com>
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

On Tue, 3 May 2022 12:12:09 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Gwendal Grignou (2022-04-29 15:01:42)
> > Based on device tree setting, set the internal analog gain.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---  
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied,
