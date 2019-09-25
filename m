Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315CBBE2E7
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 18:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392150AbfIYQyp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 12:54:45 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43904 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392097AbfIYQyp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 12:54:45 -0400
Received: by mail-pf1-f174.google.com with SMTP id a2so3865020pfo.10;
        Wed, 25 Sep 2019 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXKkE3u4Gt25Vll7joSYrDNRO6uCZgGWYBpw2Jrfy5k=;
        b=SD0ltrXBhGjEgN77oTEuFT6vJGiLOs/8mOKzZi0irWBPOAQyzb2Fya8tlSwvrLHMW6
         whp9B/+NZTj75Y66+QQiarwrGnRChibsPrl+tRSXOamZweX19lvFvZlQCjL2ngPY7CT2
         2/HA1F6fDqA5SoAtTpc1+mMrW7DGZdJxCspONgCpgiHtE8C9O5cBARGVlpF/zAPD1x4M
         zOHxjpUi9wnGS2C7FxkzIsybJ+J8WIkND5b3NMez27Qe/9ykW6IVg1dVutowgliCJIBp
         BTUdlODscdaT67ZmdHmb94QOZ7OBtCIFNrEr6xnXgdjXJ2GegWbdLtn24P8HdYQD0pDL
         X5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXKkE3u4Gt25Vll7joSYrDNRO6uCZgGWYBpw2Jrfy5k=;
        b=ToUhwPrlWKcmGa3PwYgEh/DIsYJwqo0q8RXiBpHXYbARx3HgVutRifDwMlK+HcIFvM
         bLD0ZuTpM77DEEP19/EA2jM8CTNUUjKiPaXy+PSgKeO2QftdSSvPk2sVgD3g4aWD7Ba/
         /1L+NdEyxGOCz+bkJ9ybp7PItqK8cGbvI6EK/EeHOK6+x5H0pcUtVmRf3ewSCxLaeNhT
         oiOzCIxoemLKHUIcBn4AeRKfP66LkiMjN7pGlXM87Qj2kG6XyPQqiaBrM1vnqYO74X3W
         WZr0FZ+Nv+Q9q4BUpNy51M+fv/u4Rmde+f2iEdAY4QvGgLgtoVW77QzFGNcNpzJnVg7S
         g7Gw==
X-Gm-Message-State: APjAAAW7/QDxdfBJcrX3vCib8JYGtc4Gh0sAI45hAscxZZwdzzktBwo8
        cCxbTYs0xuuQecs7QYUcGEk=
X-Google-Smtp-Source: APXvYqyIBiC1Po73o/eEPNSh26glwKPL/n/W7ckEbniNHmVMvuIJ0GnvXtzza43cS3aMSFo4kiunyg==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr10683550pfi.252.1569430484220;
        Wed, 25 Sep 2019 09:54:44 -0700 (PDT)
Received: from SARKAR ([1.186.12.91])
        by smtp.gmail.com with ESMTPSA id 2sm6268498pfo.91.2019.09.25.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 09:54:43 -0700 (PDT)
Date:   Wed, 25 Sep 2019 22:24:34 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Crt Mori <cmo@melexis.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        linux-newbie@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org
Subject: Re: Hardware prerequisites for driver development
Message-ID: <20190925165356.GA28917@SARKAR>
References: <20190925081836.GA22717@SARKAR>
 <CAKv63utZ+JSL=PH10bQdCYbrzoy0XBc_+UrVNFwTS2dkyjjxOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv63utZ+JSL=PH10bQdCYbrzoy0XBc_+UrVNFwTS2dkyjjxOw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 25, 2019 at 10:32:02AM +0200, Crt Mori wrote:
> Hi Rohit,
> There are many companies for hobbyists which sell sensors included in
> IIO subsystem and for sure some electronic component store in your
> local area. Price of sensor can be from 0.10 USD to 10 USD. Then you
> plug this sensor to your Linux board (Beaglebone Black is Linux
> Foundation preferred, although there are others including Raspberry PI
> - can even be RPI Zero if you are on a budget, Odroid, Linaro, ...)
> and you will need to provide correct voltage/current for the sensor.
> Easiests is that you pick sensors which are 3.3V or 5V domains,
> because you have pins on most Linux boards with this voltages and
> these pins supply enough current for most iio sensors. Then you just
> connect (wire) power pin on sensor to power pin on your board, and
> then communication pins from sensor to board and ground from sensor to
> board. Some addition into dts will be needed for the Linux to know
> where your sensor is connected at, but then it should work as
> plug-and-play.
> 
> I hope I did not miss too many steps in between :)
> 
> Crt

Hi Crt,
Thanks for replying, your answer was super detailed and helpful.

Thanks,
Rohit
