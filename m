Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2B4909F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfFQTyu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 17 Jun 2019 15:54:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:54082 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFQTyu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 15:54:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 50DCC6125473;
        Mon, 17 Jun 2019 21:54:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pX_4MBQoTrkS; Mon, 17 Jun 2019 21:54:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9CE1A6125474;
        Mon, 17 Jun 2019 21:54:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L-9kwGPTSA4Y; Mon, 17 Jun 2019 21:54:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 717096125473;
        Mon, 17 Jun 2019 21:54:45 +0200 (CEST)
Date:   Mon, 17 Jun 2019 21:54:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kjeld Flarup <kfa@deif.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Message-ID: <1644235064.95157.1560801285401.JavaMail.zimbra@nod.at>
In-Reply-To: <e33254e5-3e8e-fc86-de72-b3dd2f6c310c@infradead.org>
References: <e33254e5-3e8e-fc86-de72-b3dd2f6c310c@infradead.org>
Subject: Re: [PATCH] counter: fix ftm-quaddec build error on UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: counter: fix ftm-quaddec build error on UML
Thread-Index: eEfWTSXRju2JBcEkIrpay7AI04j7dg==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

----- Ursprüngliche Mail -----
> Von: "Randy Dunlap" <rdunlap@infradead.org>
> An: "linux-kernel" <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
> CC: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Kjeld Flarup" <kfa@deif.com>, "Patrick Havelange"
> <patrick.havelange@essensium.com>, "William Breathitt Gray" <vilhelm.gray@gmail.com>, "richard" <richard@nod.at>
> Gesendet: Montag, 17. Juni 2019 18:21:40
> Betreff: [PATCH] counter: fix ftm-quaddec build error on UML

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build error on user-mode Linux, which does not set HAS_IOMEM,
> so devm_ioremap() is not available.  Fixes this build error:
> 
> ERROR: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!
> 
> Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter
> driver")
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

AFAICT Patrick fixed this already.

Thanks,
//richard
