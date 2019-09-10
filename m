Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF88AF241
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfIJUZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 16:25:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44894 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfIJUZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 16:25:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id k6so9870047wrn.11;
        Tue, 10 Sep 2019 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=va7zx4dWy4opl/0MisZyc5Dgg3A7vjbqzLK/FnBX/Ho=;
        b=fviAnWWVJY2LWZyAlaPZFkG1cdl//otHF8ct4EeO410hyLBcHPd/6eqIpKhqbLB0nc
         NAXmIsmJRoD9Qr1ij5k9f05AyQyRVETf3UdJ/f+pQEKVzFuILU/XMFb00dPBBXlKHmjq
         tq6IWXLkAoLv6e4pTGROdEZdZk/q/nAoYZQHfgFEeTphpqiJ82hYWPO4BKFXidU8rkxY
         AvmU680qKKnUV10BUlK8USgig7Ot+YDY90jraycKKxyS6N090oV+rGyIpWj6fLVb59Qn
         H74ui4HynoVaB0/YzYu3HvXysTKS2o8ZLsZ8cabU2yo8uRHvAtO8Ja3C7ziZ67p/gEI3
         ki2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=va7zx4dWy4opl/0MisZyc5Dgg3A7vjbqzLK/FnBX/Ho=;
        b=T13ZAWMR6oK5ASMNZ7gJI4TGXSf2ejI8TVdEuiGkFx+E9LWJcVj/w5Kdaqcjdp48Xy
         z7nGMuctUEiCY92I7InFDxjCtV9w5Sm8L/andWSEpncDNXYZGs/1upQPFx8fOU6B0Z80
         gLR/lxtbShsUBRILYHaYzvo2XFXhxTk/vnHb1kNcOceBvUAjgNqsuPG+SsSBtXSjke7Z
         SQMwas7wocWgiNPveVeJ2iJw4iVmcHP1+yFyxseRrhpZI7zmqgPk35OWGsHz8KqULDdR
         cpRRtjemIBlk8OCpTX1av/BLi+3PWGOFISiyACT+srVUVW2q6HSYuvu1Ggi/1lVhRKna
         cqHw==
X-Gm-Message-State: APjAAAUsNGCMqkhXOPDRwlRudnY1AgHM66/xcGv60kgJj1OOgEj+RJLf
        w10UQYJ3KWkEiQQKg9iBblLxk4yvjuE=
X-Google-Smtp-Source: APXvYqxopsBTm1LI6ZET3eOZ+cxvt4V+YcW4hRdhrbBo6FMZ0k8YPNAnPTjK3cnFDWGFBSHhF8gPSA==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr30042573wru.51.1568147114468;
        Tue, 10 Sep 2019 13:25:14 -0700 (PDT)
Received: from rocinante ([91.64.150.195])
        by smtp.gmail.com with ESMTPSA id g3sm8305904wrq.64.2019.09.10.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 13:25:13 -0700 (PDT)
Date:   Tue, 10 Sep 2019 22:25:06 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: Move static keyword to the front of
 declaration
Message-ID: <20190910202504.GA19939@rocinante>
References: <20190902113132.26658-1-kw@linux.com>
 <20190908114944.18bb78e3@archlinux>
 <20190908135208.GA29162@rocinante>
 <20190910143550.00000e64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910143550.00000e64@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thank you for the feedback.  I really appreciate it.

[...]
> We can do that of course, but that's nothing to do with moving the static
> keyword to the front of the declaration which is what the patch claims
> to be doing.

I see your point.  I am going to send a v2 that hopefully will be much
cleaner and better worded.  Thank you!

Krzysztof
