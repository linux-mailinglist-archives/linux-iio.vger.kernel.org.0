Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9609A7C7261
	for <lists+linux-iio@lfdr.de>; Thu, 12 Oct 2023 18:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbjJLQX1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Oct 2023 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbjJLQX0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2023 12:23:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F1CA
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:23:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so3503051fa.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Oct 2023 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697127803; x=1697732603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4LH3Sij9XQU79jEPgJn0yMrYODWkACYHDE2obGOHWY=;
        b=lNkMMStv2VG/yLi+jmTLOWikgJ3VJgE+kGr40cGti5QrmEhf6Yp0upLBeqReLj+Da8
         H5f/KZR264WVEU5MepKvnOs2JHBxONPNbDzg4Zob5v8jZhCNsg+eeLQ1yU6P3gWOpUjy
         O1FIL+jgTNVWgUG3LriklIbQs9BPq8MC443NZR14UGrBkM8eCnNRZF3mtdkbHLnPV8Qg
         1y5+i9ObU09w62ulsA+VBzNjDLGBQMoriSIChusbtSQThsguzamTVTxpTixpN7KeRiDi
         QmzKUIuE1+mTWEQlxkSb+3G/ufPVlxWGR/RJNZyCJBoKRQbQh81c8myvFA17nRwKDn8/
         /rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127803; x=1697732603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4LH3Sij9XQU79jEPgJn0yMrYODWkACYHDE2obGOHWY=;
        b=rrx1bGsAFrCpgVSzDdXWpgC8So3HOiubfCfWK/MzL91HKIpFIWIHHM7yRBaMK21J6V
         fGr34z/Zw7LmPuS5UibucY8cP15dQSzYsbH6S2ZIqMLwj/0kCm86LofBuJF3UV39EvcH
         cXzgZHRyt//e3ROt70NUn5jVfTHfTycQ5Wsmn+dVmG7HuNhUtw0SPciOB1adfsJgLRyD
         ABu2/nlArcm/I4pzX5C7ejsTK13r12Q2reYByoKHHiS5HZ9WzWmKT7PKGilCa9bQ4S4N
         DRsz8F/qH1yWpd8kmdTBILbmfUCuCKhOOlL7t6P0ccqOe+jBWxktaslZV0rR0VnNX+dQ
         f88A==
X-Gm-Message-State: AOJu0YztQ5R7lC/fnfRFoFzpP1PDKcVju0RPhzc41m2+gZEiVo7WG9nO
        BlCtKpWjErPMRy0+/hIEi1Zept0V2X8xevTnESyZug==
X-Google-Smtp-Source: AGHT+IFjGWcALEDp/yA+Wb5/VW6uEkBWP/hZtqU8vCLB497zeqKckI6Gl60gFQvmvGF2G9wgIXC3eDKXw8l+xQvN/cI=
X-Received: by 2002:a2e:97d3:0:b0:2bc:c3ad:f418 with SMTP id
 m19-20020a2e97d3000000b002bcc3adf418mr25123355ljj.20.1697127803015; Thu, 12
 Oct 2023 09:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
 <20231010-ad2s1210-mainline-v5-4-35a0f6ffa04a@baylibre.com> <20231012092522.27ef48dd@jic23-huawei>
In-Reply-To: <20231012092522.27ef48dd@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 12 Oct 2023 11:23:11 -0500
Message-ID: <CAMknhBEzbeUgQweKk7+tmwRTA4XpkMdEHQO+UFRLrcFvQaOf8w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: resolver: ad2s1210: move out of staging
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 12, 2023 at 3:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 10 Oct 2023 16:12:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This moves the ad2s1210 resolver driver out of staging. The driver has
> > been fixed up and is ready to graduate.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v5 changes: New patch in v5.
> >
> > Diff was made with file rename detection turned off so we can see the f=
ull
> > driver code for one last check through. sysfs-bus-iio-resolver-ad2s1210=
 and
> > ad2s1210.c are just moved (no changes).
>
> Excellent.  Great work btw - this looks really nice now.
>
> I did a final scan through (most of the code was familiar for some reason=
 :)

Thanks for all of the reviews. There were less than 200 lines left
(mostly blank lines and boilerplate) that didn't get touched!
