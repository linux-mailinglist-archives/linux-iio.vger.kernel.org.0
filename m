Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B821B0F61
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgDTPKz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 11:10:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36114 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729409AbgDTPKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 11:10:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4CE9747713;
        Mon, 20 Apr 2020 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1587395450; x=1589209851; bh=Ztzt+ACrbhA1V7urHbdBIUTDU
        VhH8coNUJQ+KzIU36A=; b=JtUxxuUHit+PS9PTXVvnivhbB+JdZf0bAXZKEtFBB
        1F1See41ZPkp1qsgMRj6TEiiHxFapE+B8/39HV22udoGLM+lWMPSN5FDIWyCM7sa
        UJfyo/iFlUyzX4XyiqTsnMc+AA8vOPIWyLK58H+K+xt7oSrzVWkaNVcMIB8Tiv/X
        bY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SIVoWAC8CIPi; Mon, 20 Apr 2020 18:10:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 28D6547702;
        Mon, 20 Apr 2020 18:10:50 +0300 (MSK)
Received: from localhost.localdomain (10.199.1.170) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 20 Apr 2020 18:10:50 +0300
Message-ID: <fc97e2490ee8d02aabd149c70248f17453c605d8.camel@yadro.com>
Subject: Re: [PATCH v9 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-iio@vger.kernel.org>
Date:   Mon, 20 Apr 2020 18:11:29 +0300
In-Reply-To: <20200418200051.4330f712@archlinux>
References: <20200417182053.22213-1-i.mikhaylov@yadro.com>
         <20200417182053.22213-3-i.mikhaylov@yadro.com>
         <alpine.DEB.2.21.2004172332530.13042@vps.pmeerw.net>
         <20200418200051.4330f712@archlinux>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.1.170]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-04-18 at 20:00 +0100, Jonathan Cameron wrote:
> On Fri, 17 Apr 2020 23:35:31 +0200 (CEST)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> 
> > On Fri, 17 Apr 2020, Ivan Mikhaylov wrote:
> > 
> > some minor comments below
> 
> I may just fix these up whilst applying but I would like to leave
> more time for Rob to take another look at the binding. So if you want
> to do another version Ivan incorporating these little bits from Peter
> then feel free! It'll make my life a tiny bit easier ;)
> 
> Jonathan
> 

Jonathan, Peter, I'll fix it after Rob's review, maybe he will add something.

Thanks.

