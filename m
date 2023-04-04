Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237556D7035
	for <lists+linux-iio@lfdr.de>; Wed,  5 Apr 2023 00:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjDDWiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjDDWiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 18:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7CD4486
        for <linux-iio@vger.kernel.org>; Tue,  4 Apr 2023 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680647833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/FbBasFGKXho73GYLTBPrVyQLxAhNzEHS05zhrQhKI=;
        b=FxPRhs0jJj32iiQ+O+BwQbq8pHnukuy5mFNXLSGOcWkaCnADNWSVVgcQuWUxPnNdqEAgsx
        1Zgd5OW0DI8fgk0ZuCrRo6dK9bsXCoGe98ky0E2zi0YxokeokehnLePF3ejs+6JEldSY4O
        6F3ayEqeIi1Srwj56iVNnsNxQpGSfSM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-diF4mZ09PwmiwVI_2w1kQw-1; Tue, 04 Apr 2023 18:36:57 -0400
X-MC-Unique: diF4mZ09PwmiwVI_2w1kQw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5446a91c40cso339216077b3.18
        for <linux-iio@vger.kernel.org>; Tue, 04 Apr 2023 15:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647817;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/FbBasFGKXho73GYLTBPrVyQLxAhNzEHS05zhrQhKI=;
        b=Wrn5Woz72WH5RLg1jcBe108ldRwma77jWyopnRirUwL9BAKny2BOtjmZezyVztpbDv
         gFdZD7Yxblaf82dhEE0/mhjkuPcLVAd8vGtX4Gvnh7e+EzhogH6zSiyk3u+lohdP/36p
         VA0yHl6+wKCCUp5kAeMzQACx7Oday3xjednm/h823B5JHOCuIqCSbkSM+IvI6pBUCcNU
         QaHon4aaFov78sRb/mbwfD3iKVGDWFhUJUyfWeTzw//H2U3xVISkREHXMyVeFOl0YEoF
         KFLozvDRWA9U/iD5NVdgp1WbEwXZ3rmHJS+W7SEhvB/frBzvs5b1oC4AT5tutAYz6D0w
         B13A==
X-Gm-Message-State: AAQBX9egkWdW4PF0TPfTRL7sbC/9g9xNXvnNbD/+lsGX2hIsWeTgrGEt
        MYf5Oi0WPL72EsuxxCk0gli9/ibSZIOepFlXesiaVAXEpHwKzwhWkEnuIFRo+XCA2+D6fyB2PXi
        oVaIudvBgX/0wuy4IEQDI
X-Received: by 2002:a25:5ec4:0:b0:b38:fad9:e1f4 with SMTP id s187-20020a255ec4000000b00b38fad9e1f4mr4523224ybb.27.1680647817160;
        Tue, 04 Apr 2023 15:36:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+Y1glYqpspXbrweNu5K2lTRooFyGui/4SyHZmHEz9m05Pv+DeGb42aYVw1FPLAl3eznsFiw==
X-Received: by 2002:a25:5ec4:0:b0:b38:fad9:e1f4 with SMTP id s187-20020a255ec4000000b00b38fad9e1f4mr4523202ybb.27.1680647816864;
        Tue, 04 Apr 2023 15:36:56 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d206-20020a251dd7000000b00b7767ca748asm3633950ybd.39.2023.04.04.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:36:56 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:36:53 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel test robot <lkp@intel.com>, jic23@kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <ZCymhaDkRkfzk2kP@x1>
References: <20230404011455.339454-1-bmasney@redhat.com>
 <202304041451.gj8oasQp-lkp@intel.com>
 <ZCwGP6rBLgbDGvkv@x1>
 <20230404123544.6m5juesxwf4tklkm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230404123544.6m5juesxwf4tklkm@pengutronix.de>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 04, 2023 at 02:35:44PM +0200, Uwe Kleine-König wrote:
> Hello Brian,
> 
> On Tue, Apr 04, 2023 at 07:13:03AM -0400, Brian Masney wrote:
> > This doesn't contain the code that's in iio/togreg [1], and that's why
> > the build failed. I originally developed / built this against
> > next-20230330. I just checked linus/master, next-20230404, iio/testing,
> > and all have the expected code that defines prox_diode_mask.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2772.c?h=togreg#n593
> 
> You might want to make use of the --base parameter to git format-patch
> for you next submission. With that the auto builders have a chance to
> test on the right tree.

I'll add the --base parameter next time. However, I think the issue is
that this compiler error is triggered by this patch [1] that's not in
any maintainer trees. I suspect the kernel test robot still has that in
it's local tree from a previous round of testing against this driver.

[1] https://lore.kernel.org/lkml/20230327120823.1369700-1-trix@redhat.com/

Brian

