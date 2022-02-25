Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06E4C44C5
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiBYMnk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 07:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiBYMni (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 07:43:38 -0500
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 04:43:06 PST
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF51A58E9;
        Fri, 25 Feb 2022 04:43:06 -0800 (PST)
Received: from [192.168.64.75] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 2E4BBE4142C;
        Fri, 25 Feb 2022 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1645792645; bh=EE+QEe/GHMvvGRYv8B/VNdQxkALgfsoBrfKyWodZ07U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Nt6p/5sy+EKCoCuRgBY5hPFRQzgifF405O9zpNG9rY/dCEt6DpxZIK9uUGGVqC9U/
         9fdlOegtQEk3YOhzfOJqgsxpFrp9cJ1r2OQFs9eXtYPQA3cWw+J6FGjJnhqDZHObph
         5/CPtXcDUyvJqS4xZcBxmzkxkMJVk8lEf3KYfJmUfXc3DNCSd+zx5AHCfTvTgh74SX
         j8WLYyCzGpFeKipXjD2N/RXs3u8E1K26ZvNBUhDNoTwZpF2aF8leBqZXHJSlTFkoIG
         HPNrhqMiiCpvmhWNZrAoEf2jfmb/kX3zMyqt0pa//IOQWgRxsEUU9BIaJe3Pfdjhbp
         UtcJpqxKhc5NA==
Message-ID: <a6e5bb87-21e7-866e-ee9b-646fcf80956b@geanix.com>
Date:   Fri, 25 Feb 2022 13:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5755: drop unrelated
 included.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
References: <20211204165817.2768110-1-jic23@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20211204165817.2768110-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 04/12/2021 17.58, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Probably a cut and paste error, but the binding header used in the
> example is for the wrong device and nothing from it is used.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Hi Joanthan,

Sorry for not seeing this :)
I hope I have updated the mailmap correctly to reflect this email address.

Br,
Sean
