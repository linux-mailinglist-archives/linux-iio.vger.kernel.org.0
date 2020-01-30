Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C641D14E411
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 21:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgA3UfI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 15:35:08 -0500
Received: from www381.your-server.de ([78.46.137.84]:37304 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 15:35:08 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1ixGWo-0006Dp-F7; Thu, 30 Jan 2020 21:35:06 +0100
Received: from [93.104.117.216] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ixGWo-000JxE-9e; Thu, 30 Jan 2020 21:35:06 +0100
Subject: Re: Temperature support for FXLS8471Q accelerometer
To:     Dylan Howey <Dylan.Howey@tennantco.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200129193237.GA14494@tennantco.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c19b2b3b-a1b9-352e-9abc-e52597512158@metafoo.de>
Date:   Thu, 30 Jan 2020 21:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129193237.GA14494@tennantco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25711/Thu Jan 30 12:38:44 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/29/20 8:32 PM, Dylan Howey wrote:
> Hi all,
> 
> The mma8452 driver supports MMA845x, MMA865x and FXLS8471Q devices.
> 
> The FXLS8471Q is unique among these devices in that it has the
> additional ability to measure temperature.
> 
> Currently there is no support in mma8452 to measure temperature when
> the device is FXLS8471Q. Would anyone be opposed to me adding support?
> I have hardware and would be able to test my changes.

Hi,

Support for new devices is always welcomed :)

If you have any questions about the IIO framework let us know.

- Lars

