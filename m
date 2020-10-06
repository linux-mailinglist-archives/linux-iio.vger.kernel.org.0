Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445F284362
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 02:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgJFAeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Oct 2020 20:34:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412DDC0613CE;
        Mon,  5 Oct 2020 17:34:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nl2so695950pjb.1;
        Mon, 05 Oct 2020 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IXQFOUHrH8bt86SLgjOWRJ9SpW6/8NcDU5WZWejyEGs=;
        b=hKjsXNmSEgGgBUoiWA5tATc5pz3P+Ovdzi9HDFr3sc0TA8enS3QcMiPxn/v+TUayf0
         OmpzJm6VdjN5mlJ1gU9VGj/WqZGlYW9ebrm/GsP4Ck3vQJOhZLBpSF2FZIQ5BC9QRrSz
         FKcZ+spZs4tA6iPPafzLANU2JvQweRRfFMDLcVN/VuucH3T4J24EzRubHw39CbRLe6Ce
         cazuuPmfbIB/IkPTqkNjTeVe753efXzo+njkx7o0uHSvOmLPqbamsAGHBz4JVHGemTTe
         w+4zx7sgTaHNQuYMofsjiN2ftVAI38PxYHVmVDTWZ3l47HjffULLlFNB57QfGI7tGEBp
         FY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IXQFOUHrH8bt86SLgjOWRJ9SpW6/8NcDU5WZWejyEGs=;
        b=huMqdWxRoUG+mVhLJUfRh7ygtXT/Wkon3NFZUT3ayBrB/sYbzEWGMdy/iHlr1Z1DoH
         JrOMQyX8oAFCGPbixmBstev0cFZzoS36buu5PIHBY1KloVoeV/fE4IQvfW11cuBVZWcG
         OFz19E4EH1VLCcUZ5yh5UbR4lNKRDBW2j5+kCJKhX0aej2EjDRV8R/HxoRZ58tk9A66H
         a1DIhyD1slvSl48gVecGchJcDTlIc8/mbaBEu9nDXevdutqwmWMIdi5VAWz4VFFx4DM0
         Jhd5kYuOJBAa+5YuwIg9As4oBr3lsLTMPtdOzXoHr2tNN6WK6NQnxDQYz8DAp46UvDiM
         nCiw==
X-Gm-Message-State: AOAM533Biw9Lxu9L+qotWmynA9z2dxZEV7q7ymUUWObqXkyVU7iDTKxb
        MZniKK2kQuqEbpnF20qRSlubdHMXJmQ=
X-Google-Smtp-Source: ABdhPJx60QfTP8SkwhetSwFfjmOhuCp2Wgxwfoy0efqga5UqMXt7YfzCnEtpb1OAS6o5ZjHkUBbCuA==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr1950157pjs.65.1601944443594;
        Mon, 05 Oct 2020 17:34:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id v9sm763862pjh.2.2020.10.05.17.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 17:34:02 -0700 (PDT)
Date:   Mon, 5 Oct 2020 17:34:00 -0700
From:   dmitry.torokhov@gmail.com
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201006003400.GN1009802@dtor-ws>
References: <20201005052420.GA3262631@dtor-ws>
 <20201005110908.GA3243@qmqm.qmqm.pl>
 <20201005173636.GK1009802@dtor-ws>
 <20201005190010.GA29936@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005190010.GA29936@qmqm.qmqm.pl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 05, 2020 at 09:00:10PM +0200, Michał Mirosław wrote:
> On Mon, Oct 05, 2020 at 10:36:36AM -0700, dmitry.torokhov@gmail.com wrote:
> > Hi Michał,
> > 
> > On Mon, Oct 05, 2020 at 01:09:08PM +0200, Michał Mirosław wrote:
> > > and breaking the loop will desync touch
> > > state (I would guess this would be noticable by next user).
> > Upon next open driver will service the interrupt and provide new set of
> > touch coordinates. Userspace is supposed to query current state of
> > device when opening it before starting processing events. Or you are
> > concerned about some other state?
> 
> From the code I would expect that there is a slight window, wher when the
> user releases the touch between close() and open(), the client that open()s
> will see a 'pressed' state until the ISR runs again (probably immediately
> because of pending interrupt). OTOH, maybe the app should be prepared
> for that anyway?

I think users should be prepared for it. There could be many users, so
anyone opening interface device (evdev or similar) can not expect that
the hardware device is in a quiesce state; it could just happen that
finger was on the surface and will be released as someone is opening the
device anyway.

Thanks.

-- 
Dmitry
