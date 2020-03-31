Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D851995C2
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgCaLt5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:49:57 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53820 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgCaLt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:49:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so966247pjb.3;
        Tue, 31 Mar 2020 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/wPvbpIMhd7MnskghgUO5jeF7ND/28Jj4zI+1cNb8CE=;
        b=cp7OQ06NQE0XtQPzutp24bGeZ2NvsNJQmmnWK3ccLOyanaxOxMc2oNRWBldBtsxLpA
         tXMZ6HXF1y9xmtg1pg8roQxQiI8fzmTobx0P/zZsZwhkq6f8NsJy2NHoPVbdlkfhH3+a
         lo8D5gucRqYfdEIqnZ4q+mCmFh3ego3D9ggr8FaK4RK+G52/NKzopGrBxquCHQFJPqKT
         p4HTq6r7yOqZlVLcnL5D/C3wiQfv6eTWeAHUEcK4F3S4DCG0pYAkqmlcHnTyBHd6n20N
         d2Dm4YyON6KekpYxDWcILIKq/wl0pzLcU861XGp0vJyJNU64KwMeK0hdPRtRZJaj/VEj
         XFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/wPvbpIMhd7MnskghgUO5jeF7ND/28Jj4zI+1cNb8CE=;
        b=SdYTTPYwrPUPtXkcZesCQCLtWH7IULY79Jk2nT6ngY7hswjGWv4EAe71t1n1aIQBR+
         la+Fs3qYOa1xfMsWJtwP3mMxXdR/GwJlRLINH0oHhpKGqtKB3gM7qqd95G49x6zNk6jS
         M0gTi/Bshz8jB9jJkpq8Y+L0c0iJemN/QohfIr22fcpGKtHV+WcMRdHdJZJZt3g2PjXN
         qyPMIFR0qHhOZ5kEP/rUl+hwZy8NfPt1Ntguyee5mPnt7MCYmeIL9UL9C6EFtxMtLvPb
         eETNxKYDKzDMjskvPIo/JIQk3ROmwOf4BPdvxlTAYqUfiaWMnTjmlokQrqw8LmdIxUZP
         LSHw==
X-Gm-Message-State: AGi0PuZr6soBG7pO0mz02I7twm6c7RX+rwtxvetQK0uL34xwdoLVtZqN
        XhL6TCoq+ZGtKUmV7j6y7b54eiBPfRhPfg==
X-Google-Smtp-Source: APiQypIBjqOl1pWqZwL+WPV3jBmwrFFA8SIvj0PVeEIp3RjvywwUIvLZPi9mZYlsFCTo4/JTUnnYwA==
X-Received: by 2002:a17:90b:4d04:: with SMTP id mw4mr3524626pjb.180.1585655395317;
        Tue, 31 Mar 2020 04:49:55 -0700 (PDT)
Received: from SARKAR ([122.178.242.244])
        by smtp.gmail.com with ESMTPSA id z66sm2843635pfz.30.2020.03.31.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:49:54 -0700 (PDT)
Message-ID: <5e832e62.1c69fb81.2a0e9.b85d@mx.google.com>
X-Google-Original-Message-ID: <20200331114951.GB7750@rohitsarkar5398@gmail.com>
Date:   Tue, 31 Mar 2020 17:19:51 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200329103818.2fce9529@archlinux>
 <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
 <BN6PR03MB33472A88BA78392686737F9099C80@BN6PR03MB3347.namprd03.prod.outlook.com>
 <74033597-c348-03df-d52f-748bf52c1a12@metafoo.de>
 <5e832756.1c69fb81.19c58.78e8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e832756.1c69fb81.19c58.78e8@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Nuno,
> > > > 
> > > I don't have the exact parts that this patch is touching but I have other parts where this patch
> > > applies and should be same. So, the idea to test this is to read the files in debugfs? Maybe also
> > > some unbind + binding?
> > > 
> > > I will try to test this still today...
> > 
> > The stress test is to open the debugfs file, then unbind the device and then
> > read from the still open debugfs file.
> Yes, also just to be sure, we need to test DEFINE_DEBUGFS_ATTRIBUTE
> along with debugfs_create_file_unsafe. I will send out another patch
> that changes debugfs_create_file to debugfs_create_file_unsafe and then
> that can be tested.
Have sent out a v2 that is ready to be tested
> > - Lars
> 
> Thanks,
> Rohit
Thanks,
Rohit
