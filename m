Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334071F648
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfEOOPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 10:15:51 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45646 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEOOPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 May 2019 10:15:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id b18so2851629wrq.12
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2019 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W5NM0DeKHYNDUTSVEaHNeFYrkLHbsrEDEcP/oFsmlAI=;
        b=o8u6mSmcjB+N6sdi1obR3bKKY9lB4pl/9bpES9tzfTykgFHJgfYyddBLS9599XeyrG
         HxR5QTHiXM3w9Xa78C5HUhM21Sln7bfTozK6vzM+zqYlLKYLdxWDG88JNb5uWwdaIf0U
         zbEt1aI40joFmVnkFdvScUGETfrJM77hA4WfUyHOBwLGOY+XH2RuXlCRn3U4UNs7VdsL
         fqTN6w1uhXH9qs1cYlQHj0tunVTiCrvF4KYUdNyRvmsGFmwiDNMpwI2qf38gRvLOJSK8
         8Ogcr7/tEBP1/027Zx74v9KtshMWK1Hvej2+WBeFdlQIgWAsg6tvKB7hlMFbJQInyb//
         g5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W5NM0DeKHYNDUTSVEaHNeFYrkLHbsrEDEcP/oFsmlAI=;
        b=A3KC9O1GYAl6Gnr1ZS7MczRuSl01JF5muGDJ3BtcT6Sh+xjN3nQbhAxuz6hXO0tNN5
         FG8puo4bSIT2/FfXSWGArCWU5vtRAVl8cEic2Ei/E3BW5TO/2f2evtyio7d47bkgA4YN
         DtMCWNjLXl5UiHd1WNhEZGzrNxy7N/LNgVauGjTAkr3L+zZyyWzYquvm+560IER9CRIw
         4l5OyZEpqVat0eeG0udvYbA0hIfXkO29U4c3JX4Ne0vxgSNBkxxD2u/KSysDSkROXaMm
         8d4yVfp53AbAuBcO5xrG9nisMiaOarv7ZhnW/NYUpehnollK+qO19/S5i+ZoczgMzn0+
         qX3Q==
X-Gm-Message-State: APjAAAUG2fuTc6jFWTErG2x2morg/ddvd6ECmmahJnIpr7rgj3ZhtcY0
        pVpWeP4VheazvKEFnYU9/+02HzPZRvgJJrMgiOEzqZ7y
X-Google-Smtp-Source: APXvYqzet2IDnMjV+rHw1WDdnbUuc5JhJep9vSwTvntuiUq3TAo1w/wSTAgYS6mE6/+hXBQPy4OuKxE8GyicapeTxIk=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr18483554wrw.225.1557929748943;
 Wed, 15 May 2019 07:15:48 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Wed, 15 May 2019 10:15:37 -0400
Message-ID: <CAD56B7eKeaobf5xES8PFLSKvMHvpe2t52-w-rnVnRJpBX7bh8Q@mail.gmail.com>
Subject: iio buffer dmaengine
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Currently I have a driver directly using a dmaengine channel and then
calling iio_push_to_buffers_with_timestamp() in the callback. I ran
accross the industrialiio-buffer-dmaengin.c implementation, and it
looks like this may be a better way to go. However, I had a few
questions.

First, am I correct that there are no current users of this interface
in the mainline kernel? I pulled the analog devices kernel and I see
users there, but the interface is a little bit different.

Second, it's not clear to me how or if multiple samples / dma transfer
and time stamping is supported.

thanks,
Paul
