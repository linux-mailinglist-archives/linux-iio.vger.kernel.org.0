Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D234A622
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCZLKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZLKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:10:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F208C0613AA
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 04:10:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r17so4416352pgi.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ESkiuzFdHr5x3dfBhpjsPkUNut5fZ7p7Th9LXZWJ8o=;
        b=D+JIORhDGQLzPhmLrsDREnMN2ksMrspCrE0CByTFKcU56lAf8vNDzgkRDRnsJIHMRE
         pV80s5Oe/tapIlLEwj/3PkVMfdGbpAcGc6QS8CT74jp92BGDlnxmUinMjGXC2YU/82DM
         BT/6Qr1K/R0VnzqjX/IVO9j+cibltEg8KNNsfDch7KazunXLMIoH3EPTLA7INXW6ghib
         A7oNsHEvULNgdVL+QeuWasUMLSRA4rcXq9k/WpTTrtfOE6QueezppGjMkfdyL9IjOkmi
         BOzPmobeAeh1OrID/iCLdMBIuwe3foMjipac4FFJ9IdNY9x4a8BnFCo59H0FlVPmqnE9
         hNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ESkiuzFdHr5x3dfBhpjsPkUNut5fZ7p7Th9LXZWJ8o=;
        b=mSYN34Bqne4Cl83jAxndRkQsXg8F63odDvSZ0HoMwHhTw/t4kmhPLm2zG8lmsASf9Z
         EH4B9+WsPsybpukoOpF1dNjHipnpVpUjqNCvKj+mywUirwtBqHPvJsxAI3T4cOWfu8+q
         h94nT4zgyfbHibaZ9gFrRnIiBycQjz42a1tI4MVUelE5ADRWJyh4+Wys2Hn5tuyWrmFG
         KBX9z1DTrKSEXdjBr5MRMEaW09aWCMk4y/lvCs+4L2GAkk3o5TORsu1f5vLwu38YzqaE
         OKccaZzlf+D7P3wH96Nij8TaYCtoG39i+uvfpEhQXoO/zIltGlM+yFM6MUTHzfwSJeV5
         Y4fw==
X-Gm-Message-State: AOAM531dP4UrmKvkEg8Dx3DjzsrXeLAGlwite78tqyY8DNUBnS3xRVVf
        gzGIxD45C1NnE/EVKyptiZMI/7WbrAsEBWr/gVN+NCdBIndagA==
X-Google-Smtp-Source: ABdhPJziPgD7BhVov+3EP5nlnL2c6Gq4njLWLdCs3aCV7GIDXii0JZCQ5XvmQfMST1xjaqS5duEisCkovegP8+pts4E=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr11440240pgq.203.1616757020665;
 Fri, 26 Mar 2021 04:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210325191855.5bfdf0e3@jic23-huawei>
In-Reply-To: <20210325191855.5bfdf0e3@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 13:10:04 +0200
Message-ID: <CAHp75VcEEx8GOnBEV=U1sYAaSokpwYQBR1uA1=XQHRaza3YrmQ@mail.gmail.com>
Subject: Re: iio togreg branch rebase.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 9:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi All,
>
> Unfortunately the mess I made of building the immutable branch earlier
> in this cycle to deal with the SCMI driver meant I'd missed some
> fixes tags that needed updating.
>
> Anyhow, upshot is I only realised during last minute tests before
> a pull request.   Had to rebase to fix, so apologies to anyone who
> happened to be basing their trees on IIO.
>
> No actual code changes, but the history will be different.
>
> I need to redo the SCMI IB merge on top, but for now the togreg
> branch should be good again.

To make less impact I use --rebase-merges option for `git rebase
--interactive ...`, so I can save as much history as possible in this
case.

> It's likely any fixes in flight for stuff this cycle will need
> their tags updating, but hopefully I'll spot them this time!



-- 
With Best Regards,
Andy Shevchenko
