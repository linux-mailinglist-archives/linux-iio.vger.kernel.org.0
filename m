Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BED2FA81B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407316AbhARR5R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436608AbhARR5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 12:57:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF6C061573
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 09:56:19 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p13so19185168ljg.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 09:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dyMV9AsEWCB/j2bkGgALu0FTcrIMk9ofSLrDs4+eMyw=;
        b=uJCZcAEEzhfxa6QUO1LgViwgpRUT3fjwvWCbBagHw13SrIdr7Q3+6RIZ7pKJdzzFHR
         ipRfxdUFn1gocr1vmO1DovYcrtrWQ72CWc6Flf7/no63R4TgkEJftdfraeWTFtlDxalr
         We7Ivvukbob/jAl6adIfUgf/N7Nphq6CJX1XgYOqYhSH4ODgU93zHstUbA/xAX2j7R07
         Hp45M8tnz7VSHcRZEdY1Ks22ud14QcXia+0dhxFo4/772g8sHSvrxbUFk+QXamKYomsy
         OQM7VAJD6Kds8G8PihgKEBG6O9vU5dwYqXBtN9TrWPtJhtB78GP4QzQLBy7DO7J0uU7k
         w3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dyMV9AsEWCB/j2bkGgALu0FTcrIMk9ofSLrDs4+eMyw=;
        b=uc8LEKUzHo2xjVGUcO2pGHlWf5jFbZi9lPT4wVrKPw7AhL6iLza8HyN2NpG3jl97KF
         /JDkjlLa5aPLsPCfZTtvKVWeRLR//vVVqJAt0pkZO4G5EDIgxIdG/ox+glgPQgY8RxDJ
         HTOtE4nCAmURgwdSH7DJ+b3hL6g2W6rfn6T+J5tnzJoQp1z1qCDhCgWBjFbzJn1cjsZD
         6CZA+CkS26glskmQLOwnv8yUGJWFR6NDxEDUmmWJGntrvZGqxB9fdPmn/EM8aaZAof/6
         ifUSGm8kmjpRFwdam0HFqT1rp3mN4rZEkLAmm6ZyTDYOLfuCqcIGqALbBxaeTEmnJNR7
         wxZQ==
X-Gm-Message-State: AOAM531WX5YrSoS0PC4ZvLh6/vYVPUMifpRE8KUAexXNjuKmu1gZOVc9
        sbobHG5GTMYV5HvGExNQT/1HygBP2RJaltOguXYpIxDbjFlvAg==
X-Google-Smtp-Source: ABdhPJyJu8JsMv/hKxULwkbJw4R7VpaDtENN3cWmSi59isBfXRR3Nk3x5AqRik93s3Lgju3ADnSYlMrQfB9FhxLMRq0=
X-Received: by 2002:a2e:5047:: with SMTP id v7mr341108ljd.242.1610992578347;
 Mon, 18 Jan 2021 09:56:18 -0800 (PST)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Mon, 18 Jan 2021 12:56:06 -0500
Message-ID: <CAD56B7equnodXB4jKnA+fcU9XqdWXiO+SnbmfPw2vDKNqUFzdw@mail.gmail.com>
Subject: xilinx ams
To:     linux-iio@vger.kernel.org,
        Manish Narani <manish.narani@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

We're still using v4 of the xilinx ams driver patch set (as of kernel 5.10.4):
https://patchwork.kernel.org/project/linux-arm-kernel/cover/1555943870-15353-1-git-send-email-manish.narani@xilinx.com/

And it's still working for us. We did have a fix to remove usage of
iio_priv_to_dev(), (I can send this if anyone is interested) but other
than that it's been fine.

I'm just going through the commit set we carry to see if I can nudge
anything along.

-Paul
