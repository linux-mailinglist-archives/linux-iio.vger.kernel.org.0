Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747469967F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBPOAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 09:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBPOAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 09:00:21 -0500
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55E497C1
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=rWlCoq1ZTbLktUBB4zD1H0bmEPrHDs9UzSQc+atRYbY=; b=VJlanjw2P3guRI2OtZ2p/fpFVG
        8h3awhkL19+lPT0qDu0ycIeLnxK0d6jVb6W5LWxOg40JKXUeocjabvUeipyfD9CJ3Ixf8Oo2eE19H
        Wzi08UK2xU7zB6buxM11HRe5uDvZ+zPToBH8K+vcK2A6M6OWHBXLjOeWBSGzV0y6lm0+mGZqup7B8
        la0cUpVgZyVgAzWyCHLma/PytOVWfbsGIzvyfju2bN/YmCvY1+LleVhE5Ol74iRjP2mypLveIqyhH
        Wq6MIqPa4pI+p0CT5mO6DLn+LK87fOvXIXTk9dU9Zcaiy32zGyj/mtI+bqdOxAo5tJW/9cJWg8uLf
        3x9OuN6w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pSenr-000PHw-KX; Thu, 16 Feb 2023 15:00:03 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pSenq-000Hld-Fn; Thu, 16 Feb 2023 15:00:02 +0100
Message-ID: <386610fc-08ce-ec04-a577-26f415b48701@metafoo.de>
Date:   Thu, 16 Feb 2023 06:00:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] iio: buffer: make sure O_NONBLOCK is respected
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
References: <20230216101452.591805-1-nuno.sa@analog.com>
 <20230216101452.591805-3-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230216101452.591805-3-nuno.sa@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26814/Thu Feb 16 09:40:04 2023)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/16/23 02:14, Nuno Sá wrote:
> For output buffers, there's no guarantee that the buffer won't be full
> in the first iteration of the loop in which case we would block
> independently of userspace passing O_NONBLOCK or not. Fix it by always
> checking the flag before going to sleep.
>
> While at it (and as it's a bit related), refactored the loop so that the
> stop condition is 'written != n', i.e, run the loop until all data has
> been copied into the IIO buffers. This makes the code a bit simpler.
>
> Fixes: 9eeee3b0bf190 ("iio: Add output buffer support")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

