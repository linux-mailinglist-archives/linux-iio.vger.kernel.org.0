Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC81CDC31
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgEKNyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730352AbgEKNyt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 09:54:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0456C061A0C
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2020 06:54:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so3972319plr.4
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2020 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:date:user-agent:mime-version:to
         :content-transfer-encoding:content-language;
        bh=kwOi5OomVd2mWFkI5Qwv5/Z7sXdiFbOlBr1MTGJwHVg=;
        b=E60n6Gg3VcmENib19GYlSh5ADT7Esgck9yj6SICfq6DBnUbmOgojLYowi8JR1xtRpv
         y+yzWHmKfj86EFA5+wIH1y0gvhVe0GeD6VRxruPKPcgnZ57/xoUVcjd1da3lyf3G0U1y
         xPAyGzerHpdcEzlz/+NyydXrJpUepZVJkXyE2zZ/3hxwD9hA7xOTGUF5ppuoca8omt4w
         taqBaoeNeVjh1mEtMCj84zvUwFzhzjjpTVlVrNK36HP2XMuYt5myhLQpfWpeUoRRWYZV
         CUjw7PQ3+cyAs2p4aTsWzaOUKzbyH4D1eAzHmou/Fra2j2VHhipEaYHJtMfzePF7116G
         p54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:date:user-agent:mime-version:to
         :content-transfer-encoding:content-language;
        bh=kwOi5OomVd2mWFkI5Qwv5/Z7sXdiFbOlBr1MTGJwHVg=;
        b=V14G7l8px2zUHkWnI7tTOKtwTO+AjbBcO9+KM7ESwxlBwJMtUwhgNG1+0HCSRAh54p
         +Jen/u2DAyKgAnJquVzhCICHsVgv/Tg6iFc7xRJ2bLJEb33cyDGcnnuzxHF76TF2B/x3
         EjSMGtx+znOicJS0Tfss99PfOVRwVjDjpHGK/sHNc22pimrQK4R4TBoiSFuMRfuu7/OF
         VN2Q9SFsZ30Ijgl+/a/uLSYRmLHDo1ElUJ3eF1Jf4V2K/ztBFUbUqaukw6BKfInJjDh5
         YMa1hGztGEMmIiLhcbhCAvQQX4qoWfeKa3Ffw9EfEtJbmk85mO93QbgSc52KWC+I8wg8
         JgWg==
X-Gm-Message-State: AGi0PuaNFkxHZRsxB6VtBMCwLj7Kl66H8o7zeY7xzligA3qLjcWN3AbO
        Ebj+oA9fIMDB+Ze1zi3f/YE=
X-Google-Smtp-Source: APiQypIkFTPS3M0Uj0TaHgOypeXKOhGoAKtZxrl998Iy/nmE3HVNASHSvk8fY4UH4N0N8LdO0sniEw==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr15952393plt.323.1589205287322;
        Mon, 11 May 2020 06:54:47 -0700 (PDT)
Received: from [192.168.1.100] ([175.176.46.58])
        by smtp.gmail.com with ESMTPSA id u17sm3535166pgo.90.2020.05.11.06.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 06:54:46 -0700 (PDT)
From:   Bruce Davis <dabrusdavi@gmail.com>
Message-ID: <92d19950-4141-ef52-8ac6-85f748c2cae9@gmail.com>
Date:   Mon, 11 May 2020 21:54:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Mr. Bruce Anderson David is my name, from UK. It would please me to 
negotiate a

possible working terms with you on an investment interest in your country.

Please get back to me for proper discussion if it would please you too.

For acquaintance and more elaborate discussions, i would encourage you 
to revert

with your cell/mobile numbers for easy communications. Reply me here
Kind regards
Mr. Bruce Anderson Davis

