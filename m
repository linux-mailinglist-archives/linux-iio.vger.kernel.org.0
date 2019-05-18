Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D26C224F0
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfERUuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 16:50:06 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:35762 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERUuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 16:50:06 -0400
Received: by mail-it1-f175.google.com with SMTP id u186so17403652ith.0
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vn2RyCDWmKESuDzCNW0HIxhUT1HDWYP1LajfWhohwac=;
        b=fv6e+BFqY6+Vl7/9wMXDnVInbpxEIOGbMINMDtOTgGYWE7qFXm3i4uIbcMQoUlebnV
         EPuUY2FPBqspxBgUzX87RVVILgkzAj1k7w0KOrJAQqKHGN7F9GwfrFDRb6F3hxh8edfu
         AtnIrAMx/PcVZPNAlQZRgC0QlbeYClZtik5NDQpDqr4m80E13FB11Y0B2zKRsOKWi2gQ
         wsQSh8H2fNipyHSEBrwCdTwbuTOQIG5rP6AB3VAwvG/y7Bfznkhmw0dApTj9rBOGcIvX
         t2gd5CqMl3sXJ06HWAWZXMgAVOcudb/70AESKWbrhlBxQCdkYLE4c1FCWB1G/2LcARyY
         UQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vn2RyCDWmKESuDzCNW0HIxhUT1HDWYP1LajfWhohwac=;
        b=i2Vu9/kqK0SZsXx2BdtTSuQQHCYbZKaeNhyf1yVADA0TAPBNi0G1TlyIdaaWky4bl7
         iyUlrywrMWV9SM2fbchpldvQAGod8U+yDWG2YOqDZLQmJV5izaFU+EQBz6dj7s1N4X2O
         O2xh0LU7TCDz/fX8DjqJiZCZM+LQjJ+UOEYAG3nJpV6w7+lk1nv62wAxOT8e3TGCwxov
         WdbmJoT8qiFjuqwJjVgmP3L/ypvzeJ09RD5G9/fxci3nEdIDxrf7HuppB4oj6IjzqR30
         RkSpfinxdKLNXNFlKIcE5TXbD68xNCHyVvchaOFZzQrZF4UOyhGn4GcgioaEWQINzIma
         5Ifw==
X-Gm-Message-State: APjAAAXKt5xBc+4smGOoekaghbdgRRh7fKiT5EysANF640PRMaxtkqcr
        jr3/EqYNilLZJ5ERhug/CzkHG3qCsl21mSqNbsV9Gh7X
X-Google-Smtp-Source: APXvYqym2JE7RHNUYQqqPpl+ZkxASTVeepIYNuV1ergmCJUMhP/wGI8P9yKT4ZSAkmNjSAK1nRJeIwPE324831t/GII=
X-Received: by 2002:a02:76d3:: with SMTP id z202mr8604387jab.139.1558212605232;
 Sat, 18 May 2019 13:50:05 -0700 (PDT)
MIME-Version: 1.0
From:   Pedro Sousa <pedroteosousa@gmail.com>
Date:   Sat, 18 May 2019 17:49:53 -0300
Message-ID: <CAMyZ8d4ya5VpgnQBS-8isgQP5RcoDbxyRGnxYWhjtL1b2RagwQ@mail.gmail.com>
Subject: Question about ADIS162XX low voltage status bit
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone,

I saw that all iio drivers ADIS162XX have a comment on the low voltage
status bit specifying 3.15V as a safe lower bound, but this value does
not match the ones in the datasheet, which are all lower. What is the
reason for this discrepancy?
