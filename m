Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA63DA6079
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfICFW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 01:22:27 -0400
Received: from mout01.posteo.de ([185.67.36.65]:48029 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfICFW1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 01:22:27 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3CF15160063
        for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2019 07:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1567488142; bh=nO1vD77nzexBhXjtfbgZ4IBNXmJtcY/c3UafO7ttWno=;
        h=Subject:To:Cc:From:Openpgp:Autocrypt:Date:From;
        b=gzRZnXjhdrfP1fdZjF7vWJW1l89LCuTM8nP49znD6xc2lbKFPzqN3KGamFoFXylZR
         0cPLzWavSEEl5qVjF45y9uyxG+AE21CopvA3Tp082I/aUPaJL4U05oeUnBYQWV9jnD
         wXSgfSPcg5prXfweTGIV+W3FMRE0xDTLvleDnEV7f7vwbnlYeeWy2q2INL/Jo6Sbpv
         hRK1MqNNnC45zEHhYu25VhYqNTZv2wOy5IMsPW/0Tay47qIVNDyxRyzwPFPj7Axpvx
         DYPn2HA+5KsQoAII5KC/rwgPnw37iDD1pRBOl48dz6yLbWaf81kyPJbITxTrCOQXtW
         Ab5k3ixJjsOYQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46MwLh6CJVz6tmD;
        Tue,  3 Sep 2019 07:22:20 +0200 (CEST)
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain value
 for LSM9DS1
To:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
 <20190827210857.718d7f9b@archlinux>
 <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
 <20190829083714.GA2880@localhost.localdomain>
 <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
 <20190830072354.GA5910@localhost.localdomain>
 <531903f2-a4df-87a8-6417-68463261b859@puri.sm>
 <20190831093224.GA5393@lore-desk-wlan.lan>
 <20190901155023.249271e1@archlinux>
From:   Martin Kepplinger <martink@posteo.de>
Openpgp: preference=signencrypt
Autocrypt: addr=martink@posteo.de; keydata=
 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
Message-ID: <d9fc24f9-192c-b5c5-5883-cde5ecfb1a11@posteo.de>
Date:   Tue, 3 Sep 2019 07:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901155023.249271e1@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01.09.19 16:50, Jonathan Cameron wrote:

[...]

> 
> Rather than messing around with a pull request that has already gone
> to Greg, I'm going to leave this as it is for now.
> 
> The trace doesn't make a lot of sense to me and whilst a bit messy (as fixed
> up by Lorenzo's follow up) I can't see why things would crash.
> 
> So needs debugging and that isn't a problem given we are only looking
> at putting this support into rc1.  Not ideal, but there is time
> to work out what is wrong and fix it up!
> 
> Thanks,
> 
> Jonathan
> 

for the record, I found the problem I've had here. It's been introduced
with the DEV_NAME change and I sent a fix (and question):

https://lore.kernel.org/linux-iio/20190903051802.22716-1-martin.kepplinger@puri.sm/T/#u

thanks,

                                   martin
