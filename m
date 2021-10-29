Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274C743FA97
	for <lists+linux-iio@lfdr.de>; Fri, 29 Oct 2021 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhJ2KUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Oct 2021 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhJ2KUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Oct 2021 06:20:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E41C061570
        for <linux-iio@vger.kernel.org>; Fri, 29 Oct 2021 03:18:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m17so35750754edc.12
        for <linux-iio@vger.kernel.org>; Fri, 29 Oct 2021 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VyoOlx1f4bY9qJ0WEn854eIaH9saJD/psl6FGa9mBmM=;
        b=mMayptbnXqhUog8SFKvEoIrhCHUqAk9F/Y4BAGnsk1/oTu8wXZFCwt3PK7HbYBfIrN
         sRJD+9YitSKglx8YNj/8m9lyR1FjdOuGv3EHCMRZRgtiGjGHJZa8Jiu0HgfnhpmDYRan
         Zs/8gRJ8f/wfl+E8UZt+HgiIvD54mNQztvTeIME6GQ1ZphigaAmNB53l9fbL+HyrvQ90
         j5pn4w8EhfkSdck9kACU5oyiAvSgGHtesRk9eyYrqufh/j5fu7cQ+D91TwR2nqCWkNRn
         mvSCsCfAekD9pG6PeWner4wfltoU+/sS1y+SxucNIzIk24PSPgxF6R0QVOsjmxkA6Pcq
         czUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=VyoOlx1f4bY9qJ0WEn854eIaH9saJD/psl6FGa9mBmM=;
        b=TXCp5DfWCbcNuat2VWzS+awI8y1gfv6IQ2yOJDm5R+oj1lxc6F5U1QdaJqV7uN6lvf
         gTy61CSg64oV4WPJfb83BAjgMUHDErLpPhYaUxaXx3Fz9DIEzpDGijlV2QII/dPKYSxT
         gWQcXgtUAbBBKzNK2wJP1VdkA+mIVsR2MZw/Y7tcY+uPCPePFJ8h5HLgDRSlqse43p94
         ZyoLv/vBWPEaW3PxLmjQ2k7zjqYo3sVQ+0cPRh4ppFGWmSe0/1nzKcQjtiOeO5QhMvNJ
         B1Ox7BuDSJHuxL0WnVhKgGa6SjcjFYNDTDmbXbmRUeh0BJMPsJoXhbgijRmGw5/DBmpX
         CR9A==
X-Gm-Message-State: AOAM533rWfAxJxnyDti5RTHQtXkAIOiW0lCShGCm3gHd0H9jXZ49Schd
        AiRXh8rLVok7yTOFFuKDvpXxdp+Z5tNzyTFc7WM=
X-Google-Smtp-Source: ABdhPJxagzV+dlgvvkfgqeBpAAnFple+h5ZPeSMI80a1l6zUbROT9lTD7W6712Dp9JXGUuZsTh61mMvc6J96AZYH3Ec=
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr14114852edz.310.1635502687672;
 Fri, 29 Oct 2021 03:18:07 -0700 (PDT)
MIME-Version: 1.0
Sender: wilfredmark1056@gmail.com
Received: by 2002:a17:907:8a03:0:0:0:0 with HTTP; Fri, 29 Oct 2021 03:18:06
 -0700 (PDT)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Fri, 29 Oct 2021 10:18:06 +0000
X-Google-Sender-Auth: OhyqNQxg8hvmV0H4BykeJAz6IUA
Message-ID: <CAOF4qqge2cy=mG5qqxZFyEu6dGbMi+Mwgrq+B3H1porUg_DSkQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello my dear ,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Mckenna Howley., a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Mckenna..
