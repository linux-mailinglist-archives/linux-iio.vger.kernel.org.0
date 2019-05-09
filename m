Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70CC1888E
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfEIKyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 06:54:41 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41965 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKyl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 06:54:41 -0400
Received: by mail-wr1-f45.google.com with SMTP id d12so2378737wrm.8
        for <linux-iio@vger.kernel.org>; Thu, 09 May 2019 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JHKZprbPfj6OTBjwiNOW13VXY53oG2/QrZuSjGw0ajA=;
        b=YRgKk+avdCoS2VQSvUP9VEFwkAN0O6cf/cbuEx/QhlGulLhkAbqfBJho21k5zOoSR6
         993nseg8LYQR71myYC48GXgXNK4s7s5hyzr3Dr581qtzqimjmDsgdAv7S0YVZlClgDrm
         bwJ9i5qvDYP1cn5Uoc/i6PBb89+uiEIfxJfv9+7RG8SWXoaaQBeFq37TWX9D1ZgjKDX+
         KgXTGJVG1L0WpdsV3rvMv5V4LTzEtzte7rVvuOJxIXyVy1WHm4JxC0/+zHDv9cqjes0j
         +4TNcLED3w4dzhYyDdrFQzdC2bMUnTWZhbf4IFXwtRiOD+vvflljf/7juFKX5gh8Wkh6
         RvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JHKZprbPfj6OTBjwiNOW13VXY53oG2/QrZuSjGw0ajA=;
        b=FV8loTniZ9wADpPQO60KWJ3wkdUk5YY3lzNDi8ZLYC5S4H3HUC/1tSro5R5nfeWVsm
         ppPOIBLYj4yXIpp3iQvr+ri2h5VpXjqCtj7N9+zfCksEIcT12sfJcBUkDAckpJ9xjVwA
         A/Z8mHxOJNY6JmOWtbouz9DtSVXV9YOaqprmNQ41s14QkUfp5PwzviQheg/YU5Qg08c9
         1Nc+vTjPFk6/FQyKWxUWPgUwsIMdoxVY9+DQXtupbs4oz7lKLMSoPexM3czMoepUhgz9
         ulC3QELFY2uo5pEEpiBG6eLhhNE9pBKepM+nERc3oJjo4qt2UbxmXVQr574LvTeM2N9i
         t90g==
X-Gm-Message-State: APjAAAU0axHs10+ycX0svuMCPJYMJAeftm3+pQN5G0yJLJZ7fObB1KCm
        GdEF2Ob0gjjBf6IDnmqXdBCmxCm3
X-Google-Smtp-Source: APXvYqx1irTft8oOrRE5k8oIlhUkGfS4lbw6Xity0BojskY4Ql8vpeKY9EhealaUA3l0dP7tJK65pg==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr2491757wrq.207.1557399278857;
        Thu, 09 May 2019 03:54:38 -0700 (PDT)
Received: from [10.0.4.19] (34.16-66-87.adsl-static.isp.belgacom.be. [87.66.16.34])
        by smtp.googlemail.com with ESMTPSA id i127sm6204377wmg.21.2019.05.09.03.54.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 03:54:37 -0700 (PDT)
To:     linux-iio@vger.kernel.org
From:   =?UTF-8?Q?Ga=c3=abtan_Carlier?= <gcembed@gmail.com>
Subject: Buffer size for iio_push_to_buffers_with_timestamp()
Message-ID: <affaf789-9292-20b6-010c-8cb8ef75e177@gmail.com>
Date:   Thu, 9 May 2019 12:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: nl
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear,

I have a question about the function iio_push_to_buffers_with_timestamp().

How kernel knows the size of the buffer ? Should the buffer always be 128 bits (with last 64 bits for timestamp) ?

Best regards,
Gaëtan.
