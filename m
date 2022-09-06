Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92A5AE5F7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Sep 2022 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiIFKyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Sep 2022 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiIFKx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Sep 2022 06:53:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663671AD83
        for <linux-iio@vger.kernel.org>; Tue,  6 Sep 2022 03:52:23 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-127d10b4f19so1386301fac.9
        for <linux-iio@vger.kernel.org>; Tue, 06 Sep 2022 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=riAAiaIh0oEv62FPyBl3UL0jQXDZKALZcUDPeGDRNBs=;
        b=IHWCxpbsJ0QmftOVVUlxVHoMCCiavK8xuYat/Tc5X3KlArMPmsqhiBij1IwK9RRRWZ
         iMwvw04b5LBEcvHQ69rN2N/qu+8dtgJhVNHeBrCOmslf+5DZXiu7eSQc+AFp8s86xkJi
         tpwHYau/efuA8DhPjyEOsIOpRCH6XXVQzFggB89yGC7boLfXWa1tOovDemCRzynO9LJ7
         JCekd97HbKqTPmY5OtUL2fT+nxoz/OcAjTvT9Vu3CpNt0UwbyxD/ZdId4AicNTCwksSi
         6p8AcfXrxWGN6viCZjsuUIixv5twsGx8T8+83PBkUgl4lHxuCNgoFNKTsMRTdD2I+NJM
         aC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=riAAiaIh0oEv62FPyBl3UL0jQXDZKALZcUDPeGDRNBs=;
        b=qrEFF40bK9n/5p+cBaeKb/f19qWMhhVd4XEVY9h0R+PCC13/dNEhquB2aCGJZbM7IF
         ujTcy8pdrDE2tASiB50bRz5ljsCgQOPll/Yb7iQzcaft31TQzEYoEYWX0fQlcOtYFNqS
         P9p/bXZ1TfJhCvZA3rC5zhNKWm3gVm0qSkqjp4TOnY87i1X3Fn8gD9gVAKxHjFRadvAX
         q4LuRPHnGlrQ4CBdHeQlcSmOmDN0DF2jmU5x0AhpBhbfNWkKGzfjGLs7VpxJ3+OD0xYX
         ai8s87cmjemhhTcAVmTnyGTeBnlLgmLFVM8GBQc0MZjyzL+Fk25tEDQtJ6ZRSM5JFa/C
         FjQQ==
X-Gm-Message-State: ACgBeo3xLuts9UFN8L73IO0PPrA6DSbicmYqsJ+oIulwAciTQxeZAkKg
        eAMbY7ygsz600Yo85snLBbhAc3NimLFO2acqE0xN/A==
X-Google-Smtp-Source: AA6agR7aM1W7eko8L8TCWV2oJ0SENxPUj3ypb5bFGFMnJytflPS2c04WQ2EC0VjnYKFrEzxxywd22aSRIVlyPPVU6Nk=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr9785518oil.7.1662461542712; Tue, 06 Sep
 2022 03:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
In-Reply-To: <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 6 Sep 2022 12:51:46 +0200
Message-ID: <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> Very good and documented code, thanks!
> I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> (due to pm_ptr() usage).
> Otherwise, with some nitpicks that wouldn't prevent a green light,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
I checked DEFINE_.*_PM_OPS usage around drivers and you either have
SIMPLE (where you define suspend/resume) or you have RUNTIME (for
runtime suspend/resume), but never are those two together. So I am a
bit puzzled how to get this working.
