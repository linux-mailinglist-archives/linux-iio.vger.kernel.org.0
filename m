Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23E5108565
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2019 23:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKXWw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Nov 2019 17:52:59 -0500
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17478 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXWw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Nov 2019 17:52:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574635958; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nkhEXIzF9+0eSVEWhcQyoV6RJb7cH7U8Gr2gkLFCjEeuJUg2huMqkHX0csaHlKyVgttBtlmDlKmWemY0aVu/zthNq2k2KSD+DscGEN05VjaeiZ11vK7T5saX6/nN7xxYjPFNNrByvVz3HcsxcsCB6lL+rDvDFh2aEdoqoFfBLCM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574635958; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VBlCIOBlmhYT1nXzZeusUrp2ZE5E5KFbCpOclqk1oRI=; 
        b=H9LIerKIxFLVX+a3CgdMu5BaAD8LkvS1IfTDtU6XBlJ4JhB/Ve3h8gklOB/hfWRDtUAJb9qdkBJOPSTTLVegEd5k5y/ffGTLwnlkWiUVFkDnLjLmFmxuOc7sgFNdTxiYP+cIQzzj6yyU8q8xgptetWnCe8uBeJ8shM+4enZtpTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1574635957113882.9905876044394; Sun, 24 Nov 2019 14:52:37 -0800 (PST)
Date:   Sun, 24 Nov 2019 22:37:34 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191124223734.GA13261@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-3-dan@dlrobertson.com>
 <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
 <20191019024351.GB8593@nessie>
 <20191021162016.531e6a2e@archlinux>
 <20191118002504.GA29469@nessie>
 <20191123125135.4c7efcb0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123125135.4c7efcb0@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 23, 2019 at 12:51:35PM +0000, Jonathan Cameron wrote:
> If a function is your preferred route you could also just use it to compute
> the values for the available table at startup?

Yeah that makes sense. I'll add that in the next patchset version.

> > The sampling ratio, frequency, etc code seems to be the most complicated part
> > of the driver. Is it typically recommended to upstream a more minimal driver
> > that might assume the defaults?
> 
> Often people upstream a first version that just uses defaults, then follow
> up (if they care) with later series adding the more fiddly elements.
> 
> Sometimes those more fiddly bits never come as a particular author
> never needed them.  That's absolutely fine.  It's a rare driver
> that supports all the features on a non trivial device!

Makes sense. I'll likely add some extra bits in a follow-up patchset, so I can
learn a bit more.

Cheers,

 - Dan

