Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7DB2A12
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2019 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfINGbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Sep 2019 02:31:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43420 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfINGbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 02:31:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so16421615pgb.10;
        Fri, 13 Sep 2019 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVFGqce6hXg1xgjjUbRr3DU/hTtC4gCd17zzruIzioo=;
        b=hpSof7dvv6lIe8W7DQpk5BCeTjvkNeTZx4bxEqqA5xBnRu6qLs7oT8xBzimuzwrR1A
         GowhOkSFjHloYLfhvprq/2BJ7lr8z4Y5YHTMKdTR/UQI0zDCyP7xmb3+ylQsKi+78WAr
         LZYA5RpiNmmfIjcV5m+NkunF8FX3ZP5uU9XJMJ0aczUU02QzX2UnQLu/Hl5zy9ltH3m9
         Nb/UbhiK3A5az3+vINCjt2l0qtzbvFq0ZIh6nItVoE2J/m5sQ68FABvwdW55TymY0i5k
         gx4P7Xbn8ONNlXNjRtQZ+3VdlPcouDQzNzWpkm7V9JY/cYdq2b6u2stff1FOUSRv71i0
         RuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVFGqce6hXg1xgjjUbRr3DU/hTtC4gCd17zzruIzioo=;
        b=CMYDsrDWqSHDuI6ibs0IpL4mDXjS9Ehe3kUS9TNlhJPwA6WelCb0zvta/2b9ndCXeb
         2MYwKyTy9gGzaF+P2v33fLpfU1YEmQHrriYdxiW5OSJJ9IaczPcb8zp7DJYeNXcSE393
         7Rq8iKxhjqFGWmNgM4nT4Tk4vL4SkQAV8WNTccP79XsMBGdAJXASufnw69yr72nKovXe
         N18oP6E5YCIrXoc3hKmvp9ABOK1SUqGLqNatoz7isFfP9oT4VmKaeNjJsk7JIBBVXsjr
         2MWUmWv/1Wg/ss9fdLcv4CN462O1iDJlmXCfqTP3vNfEVE+yBVVejtBJWNUuneiz4/yE
         JOZw==
X-Gm-Message-State: APjAAAU8ux3uvjBb+vYFvbMVRW+9GG/++nSye4ieEpcKqe3BE+CBBBHM
        OLxW0fZ4BJHTp8RMH/ujbFj034tcQ1wGHQ==
X-Google-Smtp-Source: APXvYqz85EB9T/8bW2re/5/bda83VCcoUDBOTbForZs2CzTFUStCDLqFopkefjfrCTALq9nTSYpiRg==
X-Received: by 2002:a62:2f84:: with SMTP id v126mr44146301pfv.167.1568442702481;
        Fri, 13 Sep 2019 23:31:42 -0700 (PDT)
Received: from SARKAR ([1.186.0.68])
        by smtp.gmail.com with ESMTPSA id p1sm26794272pfb.112.2019.09.13.23.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 23:31:41 -0700 (PDT)
Date:   Sat, 14 Sep 2019 12:01:36 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
Message-ID: <20190914063136.GA23166@SARKAR>
References: <20190913173821.GA5986@SARKAR>
 <20190913180103.GB5986@SARKAR>
 <ff4b5c99-086b-4456-fb2b-643a6caefcee@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff4b5c99-086b-4456-fb2b-643a6caefcee@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 13, 2019 at 03:36:03PM -0700, Randy Dunlap wrote:
> Hi,
> It works for me.  Do you have a kernel .config file?
> Does it set/enable CONFIG_IIO and some/any/all drivers in drivers/iio/accel/ ?
> 
> If you don't have a kernel .config file, I don't expect it to work.
> -- 
> ~Randy

Hey Randy,
I do have a .config file but no it does not set "CONFIG_IIO".
The weird thing is when I built the kernel initially the object files
for drivers/iio/accel/ were generated. 
That's strange right?

Thanks for helping!

Rohit
