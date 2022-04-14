Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB420500BF7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Apr 2022 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiDNLWG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Apr 2022 07:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiDNLWF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2022 07:22:05 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6511E0A0
        for <linux-iio@vger.kernel.org>; Thu, 14 Apr 2022 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=3VHbYbyKiWENvJuKOu0WVRyXLg3Rc3x6ix0VCy7kRlU=; b=ftyUh5GFaVxCrbrpVk12Ckbv8K
        EGc7EKYuKhTp5O0j1qIkRV5B1xkL8r1/nfgdAt+5NG9n0QccCf3K+9Qm7163k7Txz+dChsvGFSWMY
        nzmV8WcF8LlhxSD6JMXNqL6sOM2gLbCP+B4odzifIBJ1qet2oB9+Q0PTfI19CJmBO+Zjhinl3FTqi
        0IjQheijuTGKI1sB8+VrgPK282zKpmcgHHEh2XTE9Ud/CRBavGRWHeXgCeL2V00HxPOlONEHLOhEi
        ls/wyH1+VFZpqLsq5xUp3buXjID0FRR6zfT9oZnMinWpl73ZCFGOf+DrRzj8OQMQasMRFzYobCGbu
        uJliMZ2g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nexVe-000GBC-U8; Thu, 14 Apr 2022 13:19:34 +0200
Received: from [2001:a61:2a5d:d701:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nexVe-000O2G-PG; Thu, 14 Apr 2022 13:19:34 +0200
Message-ID: <89c89115-334b-27ae-413c-73b3006d3ffa@metafoo.de>
Date:   Thu, 14 Apr 2022 13:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: iio: imu new driver
Content-Language: en-US
To:     Fawzi Khaber <Fawzi.Khaber@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26512/Thu Apr 14 10:28:56 2022)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/14/22 12:35, Fawzi Khaber wrote:
> Hello Jonathan,
> We are currently implementing a new driver for an invensense chip similar to
> iio/imu/inv_icm42600. The chip has 2 sensors a gyroscope and an
> accelerometer, and we are wandering if it was better the have two
> IIO devices, one for each sensor, or just one IIO device with two buffers.

Are these two completely independent sensors that only sit in the same 
package or do they share a common clock and the data acquisition can be 
synchronized?

If it is the latter the best might be to have a single device with a 
single buffer.

Typical algorithms that process IMU data, like odometry, want to process 
the accelerator and gyroscope data jointly. If the data gets 
artificially separated into two buffers it first has to be re-aligned, 
which might be tricky to do.

- Lars

