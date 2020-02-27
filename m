Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C647E17285B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 20:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgB0TLy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 14:11:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40508 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgB0TLx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 14:11:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so312757pfb.7
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2020 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCKOz7GehZTvcPyZC1ovjqK4rN2qxwyBDW+6Fw8fybY=;
        b=WnD5fq/geRbFD30BbBYNzaPZrJMKN9WyKEk/U4nDCsNSWJ1ccypy3VD0ZZgvgN7qDL
         NQ2WQNIujOYFWWCs27qtJBqjOB/wriJUsaO5CUeWQ3MDlN4Z1gF0j9Fc4MOTfAuri7jA
         E2geBUMpEPSM5FVqbaSxBHxdOo21K04ASeJxEfu7YnyrhQXFAsJB0V7HXkC2kONma6X2
         GR7JWXFlh18msF9JQxOxRQ9HL5RwqC+HGjly7A/bU9xg3oQibNrL07xBW0G1wnCwZB0E
         C4h+osFjDnej6MDBVh/25mvYI+HJafh0DQK2Qe0qgFiLZbZNstZ07HRndEtsTV69q6O9
         9SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCKOz7GehZTvcPyZC1ovjqK4rN2qxwyBDW+6Fw8fybY=;
        b=lhq6Lenj0wnhOm+q3jZqTDW2Lvp52pZxm/WzFNe11RdSKoB0OBAoQjRNJXzjT/5L2G
         YbNXMWqEry1G4bXFZQaazldpzji2t1uG0ah10tLEuFI9wZDGD2iz+3iejPn4NggTXsqF
         AZzfPTwKE8IZKag0cMtQV0++oOICQs10P3ydax9xWaqR3Rp1tgFhZeFeSj3dhgHLLECs
         nDfkSAUxDVnOBTLzXNHxnamBe6SpMw4tXIiGHbWmPabMad7IRfz4g55Hdt3vhtJHBUy0
         AVJIv+1cO2RLG5kdcGd0L9B1ih0r+BBT00sYzyiRkLNn7+Xcu7hKSGkg2sKWIREH/dXI
         LcJQ==
X-Gm-Message-State: APjAAAVfMtZd3Rq7I8yjSg9hS9xUMYSjGWokvocGkrk2FeP2QjM+HF0B
        o7FLbel9ywKpCqJxLzXVNjY=
X-Google-Smtp-Source: APXvYqxI3dsuvjHzkdOh63wqtCj4Jd85ow+bTQUstZIxswpaVRjiyqiRwwuBfzAA+ue5ycIVFe+qgA==
X-Received: by 2002:aa7:95a9:: with SMTP id a9mr441612pfk.15.1582830712949;
        Thu, 27 Feb 2020 11:11:52 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id q4sm8509948pfl.175.2020.02.27.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:11:52 -0800 (PST)
Message-ID: <5e581478.1c69fb81.6d4cd.579e@mx.google.com>
X-Google-Original-Message-ID: <20200227191147.GA20710@rohitsarkar5398@gmail.com>
Date:   Fri, 28 Feb 2020 00:41:48 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, alexandru.Ardelean@analog.com
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
References: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+CC Jonathan and Alexandru
