Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0553218A366
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRT6X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 15:58:23 -0400
Received: from www381.your-server.de ([78.46.137.84]:39990 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRT6X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 15:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fIii/0fagajKrXGsRklEGirD/XPNR5YjphSMMdZ8yXk=; b=TOdJZZvqu5V411xR4uBucHo83e
        Fu53u8UGCe4AGvCOk5FsZvZ0NCUHsiVtELi07OalWWajn3+zlZP/sqyu0ppp+wHozpVPYJdqL0Ymf
        fyBqrC1ZBFxiYA07BT7SjuQs/jE5z2YU0mpTTZuiicxAPUsR6hkUi7PkdV/D3rVtAbFpLZ/sK4Oj9
        pv8nMB4I6bZ1N4im2hbnW+bG+9HPIAUQQPPmWwu9wYtbQKkzyDcjGMPMWOSGU0wDLQlyDsgLqKNVb
        dApUKINAppMlpkhjQaiWRtSfzGPU/2niRqxYZOJH5PWNKgtr9BUQpaPt8GBTqv20Tkl2Jo7DMsgJa
        ivSAhmrw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEepU-0005IR-3v; Wed, 18 Mar 2020 20:58:16 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEepT-000OGE-Pw; Wed, 18 Mar 2020 20:58:15 +0100
Subject: Re: [PATCH v2 0/3] staging: iio: adc: General code reformatting /
 cleanup patchset
To:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <cover.1584557481.git.mh12gx2825@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c711dfb8-dfe2-4d48-1d9f-414d48adda06@metafoo.de>
Date:   Wed, 18 Mar 2020 20:58:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1584557481.git.mh12gx2825@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 8:07 PM, Deepak R Varma wrote:
> Address code formatting warnings and check messages flagged by
> checkpatch script. Also include another improvement for correcting macro
> name typos. Changes intended to improve readability of code.
> 
> Changes since v1:
> 	1. Add separate patch for code re-indentation comment
> 	2. Add separate patch for correcting macro names as suggested by
> 	   Lars-Peter.
> 	3. Update variable name from sync* to sinc* as suggested by
> 	   Stefano.
> 	4. Revert patch intended to add space around "-" operator. It
> 	   was a string with a "-" sign further formatted using
> 	   stringification. That patch is out of the patchset now.
> 
> 
> Deepak R Varma (3):
>    staging: iio: adc: ad7192: Re-indent enum labels
>    staging: iio: adc: ad7192: Correct macro names from SYNC to SINC
>    staging: iio: adc: ad7192: Reformat lines crossing 80 columns

Hi,

The patches all look very good, thanks.

Just one thing, make sure that you base your patches on Jonathan's 
latest development tree. The ad7192 drivers was just moved out of 
staging 2 weeks ago, so the file path in your patches is no longer 
correct. But the patches themselves look good and should be applied 
regardless of whether the driver is in staging or not.

See 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=b581f748cce00f4cbd6c76c4f301840403dece7b 
for the patch that moved it out of staging.

Jonathan's development tree is the togreg branch from his repository at 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/.

You can add it as an additional remote to your git checkout using

git remote add iio 
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git fetch iio

And then you can reference the dev branch as iio/togreg to for example 
rebase your local branch ontop of it.

- Lars
