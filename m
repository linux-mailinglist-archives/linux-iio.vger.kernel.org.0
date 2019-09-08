Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71DACF1D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfIHNwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 09:52:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42123 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfIHNwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2019 09:52:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so11013631wrm.9;
        Sun, 08 Sep 2019 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LGw90/UVGk+QEa0OVvDfU9BMlKodboT6J/WmPDm8rBg=;
        b=DjexVd6dz7KQq1XfdAg/oG77YUvvXel7yrm0iiwfoGp0qXQIfveg00d78JiMuC3OZ1
         ROwc3acSTsoME5EtB5PPKpkjr76BFxzmo4o7NjyGXDC5U0D8LEbh2PD3PUlGEQwX4Uc4
         UodPmMInKBsCL0LQd8DZK/nVB9YnSL9b7n2YJMNhnsntL8xMFgjhZWrMVwaJ2jXNgaEG
         8im7OgoHNTyqEtHIJoCmY+cfgws4kH1+rufkClRa8wi3Ffw2/C4gXIEjsH1sOCgLVyr7
         OAscnqbo2cMEQBeDdSMzE7rRxFmxOOqmbu+uHKMM1+rX6/YjwfOMvhMUR5p9TjoHT9ti
         EFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LGw90/UVGk+QEa0OVvDfU9BMlKodboT6J/WmPDm8rBg=;
        b=AjApqOE+90GYugHcv13oW+56EzlNRz+zCIuNTe4phOawLXweD/iSgqZNZYg93RCN6Q
         a3cOZReSeiGuTiCjcT/PEGzXy0DtP9RwPyDHhjPn6l76chF9OlIsiplG5Y2tugCGtH9S
         MbV77ngnLPS9hBoPAgLD1RB5R4wtf+bJ0MuhQ9x8W4/FGgYgyYESn/DYYj5BuZ3HGEBW
         ywjMjhDDdSUY11/xbg+BzoQkU1mXioOylB9LNX+j5fO9Uc/edDZtPnKorA7VsliOW1WM
         LUDRrYIBoIW8OIwqXgDETOHh8SxMvIuvNgx6YJ304HvFkEZtFYnVowsPMMcqsXCHRtnz
         soEg==
X-Gm-Message-State: APjAAAXdKjsBaCKEwSU6RGeUWOBrmAm9rCSmavv1uJL/u9UmW6HfhT6V
        z/7I3zpYOZzOdqWm/bh2fM4=
X-Google-Smtp-Source: APXvYqyZOsK+aqWwElzB2LaKFVuHA0OEwoqV7Sx+6abFRm0Y3xDPiiunSMXqYyE63hrScoKhhsu+xA==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr9858082wrr.322.1567950731822;
        Sun, 08 Sep 2019 06:52:11 -0700 (PDT)
Received: from rocinante (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id r28sm16854635wrr.94.2019.09.08.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 06:52:11 -0700 (PDT)
Date:   Sun, 8 Sep 2019 15:52:09 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: Move static keyword to the front of
 declaration
Message-ID: <20190908135208.GA29162@rocinante>
References: <20190902113132.26658-1-kw@linux.com>
 <20190908114944.18bb78e3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190908114944.18bb78e3@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thank you for feedback.

[...]
> > drivers/iio/light/bh1750.c:64:1: warning:
> >   ‘static’ is not at beginning of declaration [-Wold-style-declaration]
[...]
> This one has me confused.  The warning seems to be false as static
> is at the beginning of the declaration....
> 
> Sure we "could" combine the declaration with the definition as you have
> done here, but that has nothing much to do with the warning.
[...]

I only moved the "static const" at the front, I haven't changed the
code as it's already has been a declaration and definition.  There is
no semicolon there and the original author put a newline to separate
things which makes it look as if these were separate.

Simple example based on the existing code:

  https://godbolt.org/z/hV4HP7

I hope this helps to illustrate the change in the patch.  I apologise
if my approach was incorrect.

As part of the patch I removed the newline in an aim to make it less
confusing to anyone who will read the code in the future.  Especially,
since it makes it a bit awkward to read and when using things like
grep.

Krzysztof
