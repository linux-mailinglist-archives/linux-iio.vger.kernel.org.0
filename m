Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1DB24D1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfIMSBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 14:01:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40193 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMSBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 14:01:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so13539137pll.7;
        Fri, 13 Sep 2019 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K2aRN53gSk3ypaUyBK01i2iZOPBnYE/ufZct3v2nN3o=;
        b=Q7DCvXasQsuMUME0xuIkn3GHZFPbKhNP9UptVrlsAOdPZemP3ABLX/RxhB1QChNkO2
         y5dHaMU/+OAiUN1z02W+WCcF06zJ4ajxRvJrqWusOWKrvRiIoiJTjcpj05aGn+O2HPzz
         mnqM7eK0aYiWfkI0n/AWOi3ib9cBKHDEsVloAFqqBK7acwF2TrYyMVLvN6d16P/KOCjW
         lyhEXNbZ9skW4frGR61AeOkHyALH5JwZX5NvJ97gzGpDZfr6X/yGCbHHQCTxczL6cY5t
         UILEogjdDSJ0PiTLusi8hFHISmsxF8/kofWxi3ZhIGXbh71ONeDacn6IVFHmnB+CMAfn
         3WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2aRN53gSk3ypaUyBK01i2iZOPBnYE/ufZct3v2nN3o=;
        b=uciNR43Gs4xdDVcLHLz6fgTTogKgGw8IHgvTy0cfTUX8um7RLl+cjhP3ybLw9eNnFP
         FxFb41O3lHU+7HAkTg6wclfyl0btxBUxGB/oJHpLdXsItHyIbTH3bNlHELYxrHRHuy2S
         NeqdkTTVlGGTMCShuv66LBQzHZdKmfNpokjECs9dBDEGSUky53Ji9s9AmrKmCU4iXv5y
         Q+Q7la+QkwM9ZmyY21lxgesjBDka300TIAX6Yr9k4RCuYVHwm0pl87jqzSaOJTY/8f7B
         k/uNbOvvKrUBhXlWglS5bKj1JxiGU4WuvB4kNakft8cLPvL9QWnLVzB7QIaU/m04zM4x
         67MA==
X-Gm-Message-State: APjAAAV7m6ZBdccyY+c2nFWxZbkus0NKOU9mSnTCIIMGwb6Z39KZaJI9
        LQtg+zzFmdCze/lCsJ4nVs03hdBUkhy8Cg==
X-Google-Smtp-Source: APXvYqyhODz02dvQ5GyZu6ZI3QCagV1Q3ttSR6hCgmEY5dV04DEZMPaGQbikVuAfY/yKYJwbF52wig==
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr9943364plj.325.1568397669140;
        Fri, 13 Sep 2019 11:01:09 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id w69sm39445927pgd.91.2019.09.13.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 11:01:08 -0700 (PDT)
Date:   Fri, 13 Sep 2019 23:31:03 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-newbie@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: Problems during compiling in kernel modules
Message-ID: <20190913180103.GB5986@SARKAR>
References: <20190913173821.GA5986@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913173821.GA5986@SARKAR>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
> Hi,
> I was trying to compile a particular folder in my kernel tree.
> 
> AFAIK the way to do this is:
> `make drivers/staging/iio/` from the kernel base directory.
> 
> This gives me the following output:
> `
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
> `
> 
> No object files are generated.
> I feel like I am missing something.
> 
> Thanks,
> Rohit

I ran `make clean` in the `drivers/iio/accel` directory which removed
all object files in the first place. However running make after that
doesnt seem to compile the modules.

Thanks,
Rohit
