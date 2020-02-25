Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986AC16EAE4
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 17:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgBYQLn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 11:11:43 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:43686 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgBYQLn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 11:11:43 -0500
Received: by mail-pf1-f182.google.com with SMTP id s1so7415050pfh.10
        for <linux-iio@vger.kernel.org>; Tue, 25 Feb 2020 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=ERfSkBtAulWyckEfyJocF1XnkU//L0yjhKjvTb5TAFs=;
        b=U2+HLHP1ZAJFz1HlA3KBvnAgZ4+wvSAkFsYwk55ObJpkWbfvC0tcWSwssi6rnd9yjH
         8SqG659UP9qqPPOuhCRMEVRIeLYrFvk5LX6hUlU/X/D9zJvjjFY2QrtyGAhGfRAymXFT
         fThkiH7nihVZ9HKe99IQZoIJxC7lvx4/koNJMeJgxdBxLpvztB2AFlqQCE3Xo0N7A+uM
         sw2LKnf1XLgqAaObdQpB0XBV5ePWhdj98tIpg4LVapKOxXIf4ALWDzN6beE8C2pJQcUF
         5DRV18ZuubYX9fkC3icurArr9PCge8HTyJ5v07aNFLedLEt7vsp5NJzsBkuqoIX8nyOl
         Tw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=ERfSkBtAulWyckEfyJocF1XnkU//L0yjhKjvTb5TAFs=;
        b=RIN8H65VSKWb9/cbNoAb8Yo/OI0sIv9Vxkzj7dkecwJk8cCBjhNiFZbLhttlSWv5E+
         M+eFpfuMgULMlR/nZ1JFDdTFnOmtWJdE+liFPI4P5lxXQQwZt8Hx6nfyhYEC6DFAyzUW
         gHXrvQMrZt1DjprLxWKCQEFr+liBAhOW26wuntDxEn8CaJMADq2/rcqbRkZQfcWpGBO3
         57gVH+VtOONVX+3GAQEjaNTBTtSJZmPrQ3NImaeyqL2qf6Zi+cyxwjCvsZGVJerH0eVA
         K++/bkZlf6HjD7bcu6C3RFooVRD1P/Z30vDnQnqIcwl0Ez0vGHmpIkXdJzRnlmW06xlg
         5Org==
X-Gm-Message-State: APjAAAXK3FpxEXmioLOJs9aQVhgVb33lWQt4G6XEe9BUhufHY2R3/Wh0
        Puk80Tb4YWsakzjnDZ0YREkz7SlLFue0Jg==
X-Google-Smtp-Source: APXvYqy9VLc19j5xq13mgXMf/NeEVJWWM8/0sXuLQl4xBgpi2i/UqHAQkIZEYoqepOhFBsAARyoM9Q==
X-Received: by 2002:a62:382:: with SMTP id 124mr59766399pfd.11.1582647102268;
        Tue, 25 Feb 2020 08:11:42 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id f43sm3759514pje.23.2020.02.25.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:11:41 -0800 (PST)
Message-ID: <5e55473d.1c69fb81.82355.928d@mx.google.com>
X-Google-Original-Message-ID: <20200225161137.GA23284@rohitsarkar5398@gmail.com>
Date:   Tue, 25 Feb 2020 21:41:37 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     dragos.bogdan@analog.com
Cc:     JManeyrol@invensense.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [GSOC][RFC] Proposal
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
I am proposing to work on the accelerometer MPU6050 as my primary
project for the summer. The work items are outlined in [1] thanks to
Jean.
If time permits (which it should), I will be picking up other tasks
outlined in [2] by Jonathan and Alexandru.


Would like to hear people's views on this.

[1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
[2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
Thanks,
Rohit

