Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61910D312
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2JOg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 04:14:36 -0500
Received: from first.geanix.com ([116.203.34.67]:52096 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK2JOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Nov 2019 04:14:35 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 4D99494290;
        Fri, 29 Nov 2019 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575018641; bh=ifdZ+4J6yKvqea+7k1QNmsgvAKINRDTlXEQ605iZqJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RG0O8YxUbtuJznUl15ZA0Nx3xcqjKXQrvvDN/tNN3tNdbvzWQd35XA+WwYj0Pz0TR
         Wb0YpfKhKBO6FV3zdA5hghUgf9FbgWF1GtJob9WSPKPRRwkDpVojENizIzITFDR8Pi
         GNTb13UjJImSUBZgavlqv1cH/YZVWa99hwHaCeL2BCSNYUBkb5BuNa3VJL6j02eM+f
         BJd/yhcNyi0Dw04L0KWNrhGz/So6MN/yCr+Hf943yelx0G39K4IDYK07ek2RMBNJIX
         YzlYu7Gv7g7xnT9Vvf77czEYO8DTO5ivDqtK+8QLzMHZn0EI1JK5ARA0Fqe33gl7AF
         aQSgQbFr96wkQ==
Subject: Re: [RFC/RFT] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
References: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f3a503f1-2371-1e14-027e-a6465b2d243e@geanix.com>
Date:   Fri, 29 Nov 2019 10:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/11/2019 20.18, Lorenzo Bianconi wrote:
> Do not power-off accel unconditionally if wake-up events are enabled
> powering off the hw FIFO. At the same time do not power-off the accel
> sensor if it is 'batched' in the hw FIFO disabling sensor events
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This patch is based on https://patchwork.kernel.org/patch/11266301/
> @Sean: could you please run some tests in your environment?

Hi,

Works as expected in our environment. :)

/Sean
