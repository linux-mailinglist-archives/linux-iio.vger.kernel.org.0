Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD542FF113
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 17:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbhAUQws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 11:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbhAUQwg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 11:52:36 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F0C0613ED
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 08:51:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y8so1593041plp.8
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2021 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9S8ewfmGe0/v5JskPdXvLviSl/p5ucSKLkPcttD7Z4=;
        b=JviLCZTdmCnSU9Ih6efVEasVKflwYTvE8Aus4CzQGM9tI4Zf13sQR5AEoWJe9WhNHD
         sPZjUaG1/TEAK4ho7XQ6yp2kFRPJFhax6/7Nk2+wPxgqLw8imvFdcQHx0UYySnX9xMf6
         9e0rYMXUiQ4pcbuB+/pyVBq2x1u1Q/o0erXKvxna78RjMDT2GVFM7j7KyK0RfCszrz35
         LxaXt0SJOGNAF0ngojiZ25Boo7OskZW8i0epAZRA5EALdgeD6IyZ3dPE0p4ktkZ65Kqc
         8KY6CyKtamedvXduE0zj6jNfoZTAMF97UgEXXS39oK1OwT8iFIYLwGB0SM2s0+PMYiTT
         nzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9S8ewfmGe0/v5JskPdXvLviSl/p5ucSKLkPcttD7Z4=;
        b=oXPFQSWntno5/ULbeH5RWI5keQubEiIay3j6X3/2iApa3FtGpXc66vdmC4SGpZ7iHe
         qzU64TxYx6OXBOVLtuOsWCuQiVrS+M4uSPkxEmYXpmRJJMur/i97aClHOf/bUuA04+H4
         Qi/2W2LtNpd6XAyW/a0L4P9PNAGkDscPZi5cmTGR9D9OVAb9mG3BP23wBfkmosKeeakI
         Z2iG3dEU9H5EDnVTEyShk1twA6qX2aSkV7k7Z+Wh/DbOT82hF7ggJMG0n0+TM1GbZBHz
         7y0B74weP1PZLKKLAGZpLJfZPOfSGZvLuAVkDgrRRJhGnlO3xfH+gGF9FbfNoIgmEjl7
         Ll8A==
X-Gm-Message-State: AOAM5307R6BzBZkdQevf3x3FggjoO2fnd/YoqPL0eQFG4mKA3gVE2cUw
        QEt9fDNvE0f3cC2RKkBlMaG2JqT1D+hvw2o7PyiRaQoMxPIs0VwP
X-Google-Smtp-Source: ABdhPJwvKgNhpBkMkDzPR1n+TzvtUkjAUuLsawsRXr3Es5sCIdGCtOYYVPb+9dtmzxsObipI2L8T01R8D+0qkYqmZCg=
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr285640pjd.181.1611247915361;
 Thu, 21 Jan 2021 08:51:55 -0800 (PST)
MIME-Version: 1.0
References: <efa4524cd07abe0a7773b24d33b64f09e0bf1f82.camel@richard-neumann.de>
In-Reply-To: <efa4524cd07abe0a7773b24d33b64f09e0bf1f82.camel@richard-neumann.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 18:52:44 +0200
Message-ID: <CAHp75Vc0aF+Gf3=c5FCcbxLRd8jON7f+xktcJOmHzFSMBv62tA@mail.gmail.com>
Subject: Re: [PATCH] - AMD Sensor Fusion Hub refactored driver with module parameters
To:     Richard Neumann <mail@richard-neumann.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 12, 2021 at 12:48 PM Richard Neumann
<mail@richard-neumann.de> wrote:
>
> From fa17269ddab9113a4325a0c22b7b71acb16404c3 Mon Sep 17 00:00:00 2001
> From: Richard Neumann <mail@richard-neumann.de>
> Date: Mon, 4 Jan 2021 20:09:39 +0100
> Subject: [PATCH 1/7] Updated MAINTAINERS and documentation.

I like what you are doing but you missed a few key points here, i.e.
tools you rather must use and some additional remarks.
 - be sure each patch has a commit message
 - when prepare a patch series, run
   % git format-patch -M -C -v<n> --cover-letter
   where <n> is a version of the series
   properly form a cover letter
    % $EDITOR 0000-* # runs your editor against the cover letter template
 - check with checkpatch.pl (in the scripts folder)
 - take care about Cc list by running
    % scripts/get_maintainer.pl --git --git-min-percent=67 00*
 -  and send with
    % git send-email 00*

I have a script [1] which helps to send a series from a repository but
it does without the checkpatch step, you may probably want to tweak
it.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko
