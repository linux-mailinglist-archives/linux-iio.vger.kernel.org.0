Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21C499AD
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfFRHB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 03:01:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45023 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRHB1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 03:01:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so8247529oib.11;
        Tue, 18 Jun 2019 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UZNDItw3ygfGYFSl3GXh76G5vlmPu1W37CyeAI/eeGI=;
        b=GTNwJZ2FSemib4K2snzDqotHuHa1Xpn7HUigru0Lq3EGx8cnAkL5PGnVIO9elWsm0Q
         IsCBWIUn5xf6aK1/3FinYcujxZJXZ5UGkeYJ9Nu3U/1hZXSeTAhxlHPhVZqdow7UcR7y
         +cF7m8LcwXbEQUz5MEqmpvfu7v463N2xGeZkmpaNhJ9OUFRFJpneYhyr1JrSmA0UQeI7
         jywN0ELJOwOhfZXyPh4YC9zcqWIwtkhLRRPIktA1BUD2HjKjjrf3cJvudy430DZSbipE
         oARwDkQ14HvuDYNanmzrRN5HV8Y76IhkBspp1iNYJM4AlQ8vWzYjtAuWKjfz/xBdLVPj
         X1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UZNDItw3ygfGYFSl3GXh76G5vlmPu1W37CyeAI/eeGI=;
        b=YOu7y6afa5duv8iEPqHncghRYzCihEgeD60j3gebVQoAygn9LNdapd+4UjW++n6Rcb
         VgqUNom2t5pUz4QOGCPugUo0kY7bvUDeKIG6JSMJYI0poXpVYkyKvDT29X7RI229Ox4X
         PO3l74hbNiMwcvUdRJmCKYxo5mGaJLBrHquqMEIJZoFtPanVjouv8i+1A078BdcSKpgf
         tU1wJ4q1AA5n384M+1T6kQM4vI5i4iO7hDpbdJ2UgnS9qOW0qkEH0uShrLSb7lFnmHT+
         lAMVWdSJOjmFcyHT9puhuCOaU5E+HFL17R/5jIf3DwOXIUXeuosHf0XEoUCYNu0SRYtr
         rBdg==
X-Gm-Message-State: APjAAAVKtemmlQkFT2sPIv/Moz5/1zSKomw+41ah2+OkeQcifiuHGWCN
        hSbdtho12mxuEFCJy3SS5wy5Ti59
X-Google-Smtp-Source: APXvYqwlvpm0Vj0sTcQaWIuQeG85F6ipiTB1Q1iMn13WnvhwvU2qOSRBT5zqcHCBEIepyHYMf4wr2g==
X-Received: by 2002:a65:64d6:: with SMTP id t22mr961807pgv.406.1560835324809;
        Mon, 17 Jun 2019 22:22:04 -0700 (PDT)
Received: from icarus ([2001:268:c0c9:ec1e:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id j23sm15654838pgb.63.2019.06.17.22.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 22:22:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:21:46 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kjeld Flarup <kfa@deif.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH] counter: fix ftm-quaddec build error on UML
Message-ID: <20190618052146.GA3656@icarus>
References: <e33254e5-3e8e-fc86-de72-b3dd2f6c310c@infradead.org>
 <1644235064.95157.1560801285401.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1644235064.95157.1560801285401.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 17, 2019 at 09:54:45PM +0200, Richard Weinberger wrote:
> Hi!
> 
> ----- Ursprüngliche Mail -----
> > Von: "Randy Dunlap" <rdunlap@infradead.org>
> > An: "linux-kernel" <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
> > CC: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Kjeld Flarup" <kfa@deif.com>, "Patrick Havelange"
> > <patrick.havelange@essensium.com>, "William Breathitt Gray" <vilhelm.gray@gmail.com>, "richard" <richard@nod.at>
> > Gesendet: Montag, 17. Juni 2019 18:21:40
> > Betreff: [PATCH] counter: fix ftm-quaddec build error on UML
> 
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix build error on user-mode Linux, which does not set HAS_IOMEM,
> > so devm_ioremap() is not available.  Fixes this build error:
> > 
> > ERROR: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!
> > 
> > Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter
> > driver")
> > 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> AFAICT Patrick fixed this already.
> 
> Thanks,
> //richard

Yes, commit 0c75376fa395 ("counter/ftm-quaddec: Add missing dependencies
in Kconfig") in Greg KH's staging repository in the staging-linus
branch should address this issue.

William Breathitt Gray
