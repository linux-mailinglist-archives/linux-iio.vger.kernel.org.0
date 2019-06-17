Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC148E3E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFQTVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 15:21:41 -0400
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:46387 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTVl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 15:21:41 -0400
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 0E86038F0D
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2019 21:21:40 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id tMFF9ZvLTJLf for <linux-iio@vger.kernel.org>;
        Mon, 17 Jun 2019 21:21:38 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 055AD38DD3
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2019 21:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
        s=felmail; t=1560799298;
        bh=NHLvYZEogbSkkBdExK6KgWpRztAhf8DB8IHH0OYU4IE=;
        h=From:Subject:Date:To:From;
        b=NGHdOBST9SDLDILZ6Q+RsOry/aqb++7L77U+zuObIYS7TVNKQB7G8RMtUtu8XYiwV
         WNnbqXcfJYFkGZs44DwADqlpkYugz7FvjDYthJYFjpK93ISIh2K6fortz8O/2YimFV
         2uzb1piBuxwC3YQEYH5wcTi5KI3YzkxKUlL6eeFlVspF/elYboMgqGlMbxqNeCu+iw
         1i3vlchCF5QFZYPRvSiYBAbVL7U+V9Oax2vJP5m2IpFKav6AaakCCTpYAOUGgR5U+Q
         XGTAzwOhnJEJWiBoOnbDjqVjM4lKlpuhrXiHxjL4bUTs6hGsjh4wCJeDtzYAv5JwrB
         msKGJxpff1ZSg==
From:   =?utf-8?Q?Zbyn=C4=9Bk_Kocur?= <zbynek.kocur@fel.cvut.cz>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: SRF04.c - wrong range for filter (line 145)
Message-Id: <B08A7378-8CBD-4B77-B18D-B0C157FAEC07@fel.cvut.cz>
Date:   Mon, 17 Jun 2019 21:21:37 +0200
To:     linux-iio@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I try to use linux kernel module for proximity sensor SRF04 and i was =
not able to measure distance longer than 1.5 m. The problem is on =
implementation maximum range filter in function srf04_read, line 145. =
The reasoning assumes that the distance to 3 meters is limited, but the =
direction back and forth is neglected. Therefore, the resulting limit is =
a maximum of 1.5 meres and not a required 3 meters. The solution is to =
come out of the formula:

                 *         distance       2 * 3 m
                 * time =3D ---------- =3D --------- =3D 18808777 ns
                 *          speed       319 m/s
                 *


Best Regards,
Zbyn=C4=9Bk Kocur
---
email: zbynek.kocur@fel.cvut.cz
phone: +420 224 354 054
web: http://www.fel.cvut.cz
Department of Telecommunications Engineering
Faculty of Electrical Engineering

